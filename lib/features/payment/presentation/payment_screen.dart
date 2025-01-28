import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Order/Presentation/screens/order_screen.dart';

class PaymentScreen extends StatelessWidget {
  final String paymentUrl;

  const PaymentScreen({super.key, required this.paymentUrl});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(paymentUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("success=true")) {
              debugPrint('Payment Successful');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderScreen(
                    qrData: "Payment successful details",
                  ),
                ),
              );
              return NavigationDecision.prevent;
            } else if (request.url.contains("payment_failure")) {
              debugPrint('Payment Failed');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Payment failed, please try again.')),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
