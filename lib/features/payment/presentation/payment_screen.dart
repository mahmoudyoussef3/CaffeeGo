import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatelessWidget {
  final String paymentUrl;

  const PaymentScreen({super.key, required this.paymentUrl});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(paymentUrl));

    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
