// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../Order/Presentation/Presentation/Orders.dart';
//
// class PaymentScreen extends StatelessWidget {
//   final String paymentUrl;
//
//   const PaymentScreen({super.key, required this.paymentUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     final WebViewController controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(paymentUrl))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.contains("success=true")) {
//               debugPrint('Payment Successful');
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => OrderScreen(
//                     qrData: "Payment successful details",
//                   ),
//                 ),
//               );
//               return NavigationDecision.prevent;
//             } else if (request.url.contains("payment_failure")) {
//               debugPrint('Payment Failed');
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                     content: Text('Payment failed, please try again.')),
//               );
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       );
//
//     return Scaffold(
//       body: WebViewWidget(
//         controller: controller,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentUrl;

  const PaymentScreen({super.key, required this.paymentUrl});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController controller;
  bool _isNavigated = false; // ✅ Prevent multiple navigations

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paymentUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          // onNavigationRequest: (NavigationRequest request) {
          //   if (_isNavigated)
          //     return NavigationDecision.prevent; // ✅ Prevent duplicate handling
          //
          //   if (request.url.contains("success=true")) {
          //     debugPrint('Payment Successful');
          //     _isNavigated = true; // ✅ Lock navigation
          //     Future.delayed(Duration(seconds: 2))
          //         .then((value) => Navigator.pushReplacement(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => OrderScreen(
          //                   qrData: "Payment successful details",
          //                 ),
          //               ),
          //             ));
          //     return NavigationDecision.prevent;
          //   } else if (request.url.contains("payment_failure")) {
          //     debugPrint('Payment Failed');
          //     _isNavigated = true; // ✅ Lock navigation
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //         content: Text('Payment failed, please try again.'),
          //       ),
          //     );
          //     Navigator.pop(context); // ✅ Exit PaymentScreen after failure
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
