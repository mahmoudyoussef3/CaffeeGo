import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../features/home/data/models/coffe_item.dart';

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
  final TextEditingController rateController = TextEditingController();
  final TextEditingController mediumController = TextEditingController();
  final TextEditingController largeController = TextEditingController();
  final TextEditingController smallController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  final uuid = Uuid();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Image Picker Error: $e");
    }
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate() && _image != null) {
      var newItem = CoffeeItem(
        id: uuid.v4(),
        name: nameController.text,
        description: descriptionController.text,
        image: _image!.path,
        category: categoryController.text,
        rate: rateController.text,
        ingredients: [],
        uniqueId: uuid.v4(),
        sizes: {"small": 2.99, "medium": 3.99, "large": 4.99},
        quantityInCart: 0,
        selectedSize: "medium",
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Coffee Item"),
        backgroundColor: AppColors.brownAppColor,
        centerTitle: true,
        foregroundColor: AppColors.offWhiteAppColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: _image == null
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.brown.shade200,
                                borderRadius: BorderRadius.circular(16)),
                            height: 250,
                            width: double.infinity,
                            child: Icon(Icons.camera_alt,
                                size: 50, color: Colors.white),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(_image!,
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover),
                          ),
                  ),
                  SizedBox(height: 10),
                  _buildTextField(
                      nameController, "Coffee Name", Icons.local_cafe),
                  _buildTextField(
                      descriptionController, "Description", Icons.description),
                  _buildTextField(
                      categoryController, "Category", Icons.category),
                  _buildTextField(rateController, "Rate", Icons.star,
                      isNumeric: true),
                  SizedBox(height: 20),
                  Text('Sizes'),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildSizeContainer('Small', smallController),
                        buildSizeContainer('Medium', mediumController),
                        buildSizeContainer('Large', largeController),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brownAppColor,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Center(
                      child: Text("Add Coffee Item",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildSizeContainer(String label, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(
          child: Row(
            children: [
              Text(label),
              SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: Center(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    controller: controller,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColors.offWhiteAppColor)),
                      filled: true,
                      fillColor: Colors.brown[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
