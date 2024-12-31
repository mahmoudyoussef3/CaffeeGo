import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import 'custom_circular_button.dart';

class CustomOrderItem extends StatefulWidget {
  const CustomOrderItem({super.key, required this.coffeeItem});
  @override
  _CustomOrderItemState createState() => _CustomOrderItemState();
  final CoffeeItem coffeeItem;
}

class _CustomOrderItemState extends State<CustomOrderItem> {
  int counter = 1;

  void _increaseCounter() {
    setState(() {
      counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      if (counter > 1) counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.offWhiteAppColor,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.coffeeItem.image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.coffeeItem.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Price: ${widget.coffeeItem.sizes['medium']}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              CircularButton(
                icon: Icons.remove,
                onPressed: _decreaseCounter,
              ),
              const SizedBox(width: 8),
              Container(
                width: 38,
                height: 35,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.brownAppColor),
                child: Center(
                  child: Text(
                    "$counter",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Increase Button
              CircularButton(
                icon: Icons.add,
                onPressed: _increaseCounter,
              ),
              const SizedBox(width: 8),

            ],
          ),
        ],
      ),
    );
  }
}
