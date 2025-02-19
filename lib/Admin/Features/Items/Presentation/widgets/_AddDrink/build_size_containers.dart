import 'package:flutter/material.dart';

class BuildSizeContainers extends StatelessWidget {
  const BuildSizeContainers({
    super.key,
    required this.mediumController,
    required this.largeController,
    required this.smallController,
  });

  final TextEditingController mediumController;
  final TextEditingController largeController;

  final TextEditingController smallController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildContainer('Small', smallController),
        buildContainer('Medium', mediumController),
        buildContainer('Large', largeController),
      ],
    );
  }

  Widget buildContainer(String label, TextEditingController controller) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          width: 80,
          child: TextFormField(
            controller: controller,
            style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
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
}
