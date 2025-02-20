import 'package:coffe_app/Admin/main_admin.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/components/app_components.dart';
import '../../../../payment/wallet_payment.dart';

class PayWithWallet extends StatelessWidget {
  const PayWithWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        AppComponents.showToastMsg('In Progress');
      },
      child: Container(
        width: 130,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColorsDarkTheme.greyAppColor),
        child: const Center(
          child: Text(
            'Mobile Wallet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
