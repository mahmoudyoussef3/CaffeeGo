import 'package:coffe_app/Admin/Features/Items/Presentation/cubits/admin_items_cubit.dart';
import 'package:coffe_app/Admin/Features/Items/Presentation/widgets/_AddDrink/build_img_picker_container.dart';
import 'package:coffe_app/Admin/Features/Items/Presentation/widgets/_AddDrink/build_size_containers.dart';
import 'package:coffe_app/Admin/Features/Items/Presentation/widgets/_AddDrink/build_text_field.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../User/features/home/data/models/coffe_item.dart';
import '../../../../../User/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import '../widgets/_AddDrink/build_add_drink_cubit.dart';
import '../widgets/_AddDrink/build_container_bloc_builder.dart';

class AddCoffeeItemScreen extends StatefulWidget {
  const AddCoffeeItemScreen({super.key});

  @override
  _AddCoffeeItemScreenState createState() => _AddCoffeeItemScreenState();
}

class _AddCoffeeItemScreenState extends State<AddCoffeeItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController mediumController = TextEditingController();
  final TextEditingController largeController = TextEditingController();
  final TextEditingController smallController = TextEditingController();
  File? _image;
  String? imgUrl;
  final picker = ImagePicker();
  final uuid = const Uuid();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        imgUrl = await uploadImageToImgur(_image!);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Image Picker Error: $e");
      }
    }
  }

  Future<String?> uploadImageToImgur(File imageFile) async {
    if (kDebugMode) {
      print('Start_img ipload');
    }
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.imgur.com/3/image'),
    );
    request.headers['Authorization'] = 'Client-ID feb2c06bb1eb337';
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonData = jsonDecode(responseData);

    if (response.statusCode == 200) {
      return jsonData['data']['link'];
    } else {
      if (kDebugMode) {
        print('Failed to upload: ${jsonData['data']['error']}');
      }
      return null;
    }
  }

  Future addCoffee() async {
    if (imgUrl == null) {
      if (kDebugMode) {
        print("Image URL is null. Cannot add coffee item.");
      }
      return;
    }

    if (_formKey.currentState!.validate() && _image != null) {
      var newItem = CoffeeItem(
        id: uuid.v4(),
        name: nameController.text,
        description: descriptionController.text,
        image: imgUrl ??
            'https://t4.ftcdn.net/jpg/01/05/90/77/360_F_105907729_4RzHYsHJ2UFt5koUI19fc6VzyFPEjeXe.jpg',
        category: categoryController.text,
        rate: '4.5',
        ingredients: [],
        uniqueId: uuid.v4(),
        sizes: {
          "small": double.tryParse(smallController.text)!,
          "medium": double.tryParse(mediumController.text)!,
          "large": double.tryParse(largeController.text)!,
        },
        quantityInCart: 0,
        selectedSize: "medium",
      );
      await BlocProvider.of<AdminItemsCubit>(context)
          .addCoffeeItem(newItem, context);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCoffeeCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        backgroundColor: AppColors.offWhiteAppColor,
        title: const Text('Add New Drink'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            color: AppColors.offWhiteAppColor,
            elevation: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildImgPickerContainer(pickImg: _pickImage, image: _image),
                    const SizedBox(height: 16),
                    BuildTextField(
                        controller: nameController,
                        label: "Name",
                        icon: Icons.local_cafe),
                    BuildTextField(
                        maxLines: 3,
                        controller: descriptionController,
                        label: "Description",
                        icon: Icons.description),
                    const SizedBox(height: 16),
                    const Text('Select Category',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    BuildCategoryBlocContainer(
                        categoryController: categoryController),
                    const SizedBox(height: 20),
                    BuildSizeContainers(
                        mediumController: mediumController,
                        largeController: largeController,
                        smallController: smallController),
                    const SizedBox(height: 32),
                    BuildAddDrinkCubit(addDrink: addCoffee),
                    const SizedBox(
                      height: 18,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
