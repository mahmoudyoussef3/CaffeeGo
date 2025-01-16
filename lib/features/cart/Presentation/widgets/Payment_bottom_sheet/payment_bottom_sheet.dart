import 'package:coffe_app/features/cart/Presentation/widgets/Payment_bottom_sheet/pay_with_card.dart';
import 'package:coffe_app/features/cart/Presentation/widgets/Payment_bottom_sheet/pay_with_wallet.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({super.key, required this.amount});
  final double amount;

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
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              backgroundColor: Colors.white,
              builder: (sheetContext) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Image.network(
                        'https://paymob.com//8080/uploads/paymob/logos/1604489841acceptLogo1.png',
                        height: 80,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Choose Payment Method',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PayWithCard(sheetContext: context, amount: amount),
                          const PayWithWallet()
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.brownAppColor,
            ),
            child: const Text(
              'Order Now',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ));
  }
}
