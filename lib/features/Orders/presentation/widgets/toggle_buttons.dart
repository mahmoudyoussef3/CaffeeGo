import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class ToggleButtonsWidget extends StatefulWidget {
  const ToggleButtonsWidget({super.key});

  @override
  _ToggleButtonsWidgetState createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  List<bool> isSelected = [true, false]; // Initial selection

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffEDEDED),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ToggleButtons(
              isSelected: isSelected,
              borderRadius: BorderRadius.circular(10),
              fillColor: AppColors.brownAppColor, // Background color of selected button
              selectedColor: Colors.white, // Text color of selected button
              color: Colors.black,
              borderColor:  Colors.transparent,
              constraints: BoxConstraints.tightFor(width: 155, height: 40),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Deliver", style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Pick Up", style: TextStyle(fontSize: 16)),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                });
              },
            ),
      ),
    );
  }
}
