import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary(
      {super.key,
      required this.priceWithoutDiscount,
      required this.priceWithDiscount});
  final double priceWithoutDiscount;
  final double priceWithDiscount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment Summary',
                style: TextStyle(
                  color: AppColors.semiBlackAppColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${priceWithoutDiscount.toStringAsFixed(2)} \$',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const DottedLine(
                direction: Axis.horizontal,
                dashColor: AppColors.semiBlackAppColor,
              ),
              const Spacer(
                flex: 3,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.local_offer_outlined,
                    color: AppColors.brownAppColor,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      '15% off for totals over \$20!',
                      style: TextStyle(
                        color: AppColors.brownAppColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Price',
                    style: TextStyle(
                      color: AppColors.brownAppColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${priceWithDiscount.toStringAsFixed(2)}\$',
                    style: const TextStyle(
                      color: AppColors.brownAppColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
