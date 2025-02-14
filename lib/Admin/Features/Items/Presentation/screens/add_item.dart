import 'dart:developer';

import 'package:coffe_app/Admin/Features/Items/Presentation/cubits/admin_items_cubit.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../features/home/data/models/coffe_item.dart';
import '../../../../../features/home/presentation/cubit/category_cubit/category_cubit.dart';
import '../../../../../features/home/presentation/widgets/_categories_widgets/categoies_container_shimmer.dart';
import '../../../../../features/home/presentation/widgets/_categories_widgets/categories_container.dart';
import '../../../AdminNotification/data/admin_notifications.dart';

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
  final uuid = Uuid();

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
      print("Image Picker Error: $e");
    }
  }

  Future<String?> uploadImageToImgur(File imageFile) async {
    print('Start_img ipload');
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
      print('Failed to upload: ${jsonData['data']['error']}');
      return null;
    }
  }

  Future addCoffee() async {
    if (imgUrl == null) {
      print("Image URL is null. Cannot add coffee item.");
      return;
    }

    if (_formKey.currentState!.validate() && _image != null) {
      var newItem = CoffeeItem(
        id: uuid.v4(),
        name: nameController.text,
        description: 'descriptionController.text',
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
      await BlocProvider.of<AdminItemsCubit>(context).addCoffeeItem(newItem);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCoffeeCategories();
  }

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Coffee Item"),
        centerTitle: true,
        backgroundColor: AppColors.brownAppColor,
        foregroundColor: AppColors.offWhiteAppColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            color: AppColors.offWhiteAppColor,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickImage();
                        setState(() {});
                      },
                      child: Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.brown.shade100,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: AppColors.offWhiteAppColor, width: 2),
                          ),
                          child: _image == null
                              ? Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: AppColors.offWhiteAppColor,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(_image!,
                                      height: 250,
                                      width: double.infinity,
                                      fit: BoxFit.cover),
                                )),
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                        nameController, "Coffee Name", Icons.local_cafe),
                    _buildTextField(descriptionController, "Description",
                        Icons.description),
                    SizedBox(height: 16),
                    Text('Price',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSizeContainer('Small', smallController),
                        _buildSizeContainer('Medium', mediumController),
                        _buildSizeContainer('Large', largeController),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text('Select Category',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, state) {
                        log("Current state in BlocBuilder: $state");
                        if (state is CategoryLoading) {
                          return CustomLoadingProgress();
                        } else if (state is CategoryError) {
                          return Text(state.errorMessage.toString());
                        } else if (state is CategorySuccess) {
                          var myCategories = state.myCategories;
                          return buildCategoryContainer(myCategories);
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 32),
                    BlocBuilder<AdminItemsCubit, AdminItemsState>(
                      builder: (context, state) {
                        if (state is AdminItemsLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.brownAppColor,
                            ),
                          );
                        } else if (state is AdminItemsError) {
                          return Text(state.errorMessage.toString());
                        } else if (state is AdminItemsLoaded) {
                          Fluttertoast.showToast(
                              msg: "New item added successfully!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pop(context);
                        }

                        return ElevatedButton(
                          onPressed: () async {
                            await addCoffee();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brownAppColor,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Center(
                            child: Text("Add Coffee Item",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                        );
                      },
                    ),
                    SizedBox(
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

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.offWhiteAppColor,
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.offWhiteAppColor,
          ),
          filled: true,
          fillColor: Colors.brown.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildSizeContainer(String label, TextEditingController controller) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        SizedBox(
          width: 80,
          height: 70,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.brown.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter value';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget buildCategoryContainer(
    List categories,
  ) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: GestureDetector(
              onTap: () {
                selectedCategory = index;
                categoryController.text = categories[index]['name'];
                setState(() {});
              },
              child: Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedCategory == index
                          ? AppColors.brownAppColor
                          : Colors.brown.shade100),
                  child: Center(
                      child: Text(
                    categories[index]['name'],
                    style: TextStyle(color: AppColors.offWhiteAppColor),
                  ))),
            ),
          );
        },
      ),
    );
  }
}

//   return Scaffold(
//     appBar: AppBar(
//       title: Text("Add Coffee Item"),
//       backgroundColor: AppColors.brownAppColor,
//       centerTitle: true,
//       foregroundColor: AppColors.offWhiteAppColor,
//     ),
//     body: SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: _image == null
//                       ? Container(
//                           decoration: BoxDecoration(
//                               color: Colors.brown.shade200,
//                               borderRadius: BorderRadius.circular(16)),
//                           height: 250,
//                           width: double.infinity,
//                           child: Icon(Icons.camera_alt,
//                               size: 50, color: Colors.white),
//                         )
//                       : ClipRRect(
//                           borderRadius: BorderRadius.circular(16),
//                           child: Image.file(_image!,
//                               height: 250,
//                               width: double.infinity,
//                               fit: BoxFit.cover),
//                         ),
//                 ),
//                 SizedBox(height: 10),
//                 _buildTextField(
//                     nameController, "Coffee Name", Icons.local_cafe),
//                 _buildTextField(
//                     descriptionController, "Description", Icons.description),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text('Price'),
//                 Column(
//                   children: [
//                     buildSizeContainer('Small', smallController),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     buildSizeContainer('Medium', mediumController),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     buildSizeContainer('Large', largeController),
//                   ],
//                 ),
//                 Text(
//                   'Select Category',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 BlocBuilder<CategoryCubit, CategoryState>(
//                   builder: (context, state) {
//                     log("Current state in BlocBuilder: $state");
//                     if (state is CategoryLoading) {
//                       return const CategoriesContainerShimmer();
//                     } else if (state is CategoryError) {
//                       return Text(state.errorMessage.toString());
//                     } else if (state is CategorySuccess) {
//                       var myCategories = state.myCategories;
//                       return buildCategoryContainer(myCategories);
//                     }
//
//                     return const SizedBox.shrink();
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _saveItem,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.brownAppColor,
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                   ),
//                   child: Center(
//                     child: Text("Add Coffee Item",
//                         style: TextStyle(fontSize: 18, color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// Widget _buildTextField(
//     TextEditingController controller, String label, IconData icon,
//     {bool isNumeric = false}) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0),
//     child: SizedBox(
//       child: TextFormField(
//         controller: controller,
//         keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter $label';
//           }
//           return null;
//         },
//       ),
//     ),
//   );
// }
//
// Widget buildSizeContainer(String label, TextEditingController controller) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         label,
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//       ),
//       Container(
//         decoration:
//             BoxDecoration(border: Border.all(color: Colors.transparent)),
//         width: 100,
//         height: 40,
//         child: Center(
//           child: TextFormField(
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return '';
//               }
//               return null;
//             },
//             keyboardType: TextInputType.number,
//             style: TextStyle(color: Colors.white),
//             controller: controller,
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: AppColors.offWhiteAppColor)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: AppColors.offWhiteAppColor)),
//               filled: true,
//               fillColor: Colors.brown[200],
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//         ),
//       )
//     ],
//   );
// }
