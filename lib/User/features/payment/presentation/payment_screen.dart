import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Orders/Data/models/order_model.dart';
import '../../Orders/presentation/cubits/order_cubit/orders_cubit.dart';
import '../../Orders/presentation/screens/order_screen.dart';
import '../../cart/Presentation/cubit/user_data_cubit.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentUrl;
  final double totalPrice;
  final OrderModel orderModel;

  const PaymentScreen(
      {super.key,
      required this.paymentUrl,
      required this.orderModel,
      required this.totalPrice});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController controller;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paymentUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('🔄 Page started loading: $url');
          },
          onPageFinished: (String url) async {
            debugPrint('✅ Page finished loading: $url');

            if (!_navigated) {
              if (url.contains("success=true")) {
                debugPrint('🎉 Payment Successful');
                _navigated = true;
                final order = widget.orderModel;

                try {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Don`t close this screen, Wait for order to sent successfully')),
                  );

                  await context.read<OrdersCubit>().updateOrderList(order);
                  await context.read<UserDataCubit>().clearCart();
                  await context
                      .read<UserDataCubit>()
                      .addOrderToOrdersAdmin(order);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        backgroundColor: Colors.white,
                        content: Text('Order sent to admin successfully! ✅')),
                  );
                  debugPrint("✅ Order sent to admin successfully");
                } catch (e) {
                  debugPrint("❌ Error updating order: $e");
                }
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderScreen(),
                      ),
                    );
                  }
                });
              } else if (url.contains("success=false") ||
                  url.contains("payment_failure")) {
                debugPrint('❌ Payment Failed');
                _navigated = true;
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Payment failed, please try again.')),
                    );
                  }
                });
              }
            }
          },
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

// }
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class PaymentScreen extends StatefulWidget {
//   final String paymentUrl;
//
//   const PaymentScreen({super.key, required this.paymentUrl});
//
//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   late final WebViewController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(widget.paymentUrl));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebViewWidget(controller: controller),
//     );
//   }
// }
//bool _isNavigated = false; // ✅ Prevent multiple navigations

// ..setNavigationDelegate(
//   NavigationDelegate(
//     onPageStarted: (String url) {
//       debugPrint('Page started loading: $url');
//     },
//     onPageFinished: (String url) {
//       debugPrint('Page finished loading: $url');
//     },
//     onNavigationRequest: (NavigationRequest request) {
//       if (_isNavigated)
//         return NavigationDecision.prevent; // ✅ Prevent duplicate handling
//
//       if (request.url.contains("success=true")) {
//         debugPrint('Payment Successful');
//         _isNavigated = true; // ✅ Lock navigation
//         // Future.delayed(Duration(seconds: 2))
//         //     .then((value) => Navigator.pushReplacement(
//         //           context,
//         //           MaterialPageRoute(
//         //             builder: (context) => OrderScreen(
//         //               qrData: "Payment successful details",
//         //             ),
//         //           ),
//         //         ));
//         return NavigationDecision.prevent;
//       } else if (request.url.contains("payment_failure")) {
//         debugPrint('Payment Failed');
//         _isNavigated = true; // ✅ Lock navigation
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Payment failed, please try again.'),
//           ),
//         );
//         Navigator.pop(context); // ✅ Exit PaymentScreen after failure
//         return NavigationDecision.prevent;
//       }
//       return NavigationDecision.navigate;
//     },
//   ),
// );
// onNavigationRequest: (NavigationRequest request) {
//   // if (request.url.contains("success=true")) {
//   //   debugPrint('Payment Successful');
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => OrderScreen(
//   //           //   qrData: "Payment successful details",
//   //           ),
//   //     ),
//   //   );
//   //   return NavigationDecision.prevent;
//   // } else if (request.url.contains("payment_failure")) {
//   //   debugPrint('Payment Failed');
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     const SnackBar(
//   //         content: Text('Payment failed, please try again.')),
//   //   );
//   //   return NavigationDecision.prevent;
//   // }
//   return NavigationDecision.navigate;
// },
