import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import 'custom_circular_button.dart';

class CustomOrderItme extends StatefulWidget {
  @override
  _CustomOrderItmeState createState() => _CustomOrderItmeState();
}

class _CustomOrderItmeState extends State<CustomOrderItme> {
  int counter = 0;

  void _increaseCounter() {
    setState(() {
      counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      if (counter > 0) counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyAppColor,
      width:double.infinity ,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Rounded Border Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/caffe_mocha.png", // Replace with your image URL
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10), // Space between image and text section

          // 2. Column for Name and Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Coffee Latte", // Replace with your name
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Rich and creamy espresso.", // Replace with your description
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),

          // 3. Counter Section with Buttons
          Row(
            children: [
              // Decrease Button
              CircularButton(
                icon: Icons.remove,
                onPressed: _decreaseCounter,
              ),
              SizedBox(width: 16),
              // Counter Text
              SizedBox(
                width: 15,
                child: Text(
                  "$counter",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Increase Button
              CircularButton(
                icon: Icons.add,
                onPressed: _increaseCounter,
              ),

            ],
          ),
        ],
      ),
    );
  }
}
