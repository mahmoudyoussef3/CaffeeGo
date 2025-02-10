import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String scannedData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        foregroundColor: AppColors.offWhiteAppColor,
        backgroundColor: AppColors.brownAppColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Card(
                elevation: 10,
                color:AppColors.offWhiteAppColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: MobileScanner(
                    onDetect: (BarcodeCapture barcodeCapture) {
                      final List<Barcode> barcodes = barcodeCapture.barcodes;
                      if (barcodes.isNotEmpty &&
                          barcodes.first.rawValue != null) {
                        setState(() {
                          scannedData = barcodes.first.rawValue!;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Card(
                elevation: 10,
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Scanned: $scannedData",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.brownAppColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
