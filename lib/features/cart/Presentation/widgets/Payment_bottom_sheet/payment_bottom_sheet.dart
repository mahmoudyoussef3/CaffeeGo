import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet(
      // {super.key, required this.amount, required this.myOrder});
      {super.key});

  // final double amount;
  // final OrderModel myOrder;

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.brownAppColor,
          ),
          child: const Text(
            'Submit Order',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ));
  }
}
