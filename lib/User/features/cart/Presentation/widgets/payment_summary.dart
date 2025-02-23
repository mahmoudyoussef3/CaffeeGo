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
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          AppColorsDarkTheme.greyAppColor,
          AppColorsDarkTheme.darkBlueAppColor,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Summary',
              style: TextStyle(
                color: AppColorsDarkTheme.whiteAppColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(
                    color: AppColorsDarkTheme.greyLighterAppColor,
                    fontSize: 16,
                  ),
                ),
                Text.rich(TextSpan(children: [
                  const TextSpan(
                    text: '\$ ',
                    style: TextStyle(
                      color: AppColorsDarkTheme.brownAppColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: priceWithoutDiscount.toStringAsFixed(2),
                    style: const TextStyle(
                      color: AppColorsDarkTheme.whiteAppColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ])),
              ],
            ),
            const SizedBox(height: 8),
            const DottedLine(
              dashColor: AppColors.semiBlackAppColor,
            ),
            const Spacer(
              flex: 2,
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
                      color: AppColorsDarkTheme.greyLighterAppColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(
                    color: AppColorsDarkTheme.whiteAppColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text.rich(TextSpan(children: [
                  const TextSpan(
                    text: '\$ ',
                    style: TextStyle(
                      color: AppColorsDarkTheme.brownAppColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: priceWithDiscount.toStringAsFixed(2),
                    style: const TextStyle(
                      color: AppColorsDarkTheme.whiteAppColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
