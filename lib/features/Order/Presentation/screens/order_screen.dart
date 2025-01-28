import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/utils/app_colors.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.qrData});
  final String qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your QR Code'),
        backgroundColor: AppColors.brownAppColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrData,
              size: 250, // Size of the QR Code
              backgroundColor: Colors.white, // Background of the QR Code
              version: QrVersions.auto, // Automatically determine version
            ),
            const SizedBox(height: 20),
            const Text(
              'Scan this QR Code to verify your payment.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
