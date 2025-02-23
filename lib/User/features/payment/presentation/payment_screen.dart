import 'package:coffe_app/Admin/main_admin.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/components/app_components.dart';
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
                _navigated = true;
                final order = widget.orderModel;
                try {
                  // AppComponents.showSnackBar(
                  //     'Don`t close this screen, Wait for order to sent successfully',
                  //     AppColorsDarkTheme.redAppColor,
                  //     context);
                  await context.read<OrdersCubit>().updateOrderList(order);
                  await context.read<UserDataCubit>().clearCart();
                  await context
                      .read<UserDataCubit>()
                      .addOrderToOrdersAdmin(order);
                  AppComponents.showToastMsg('Order sent to admin successfully!');
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
                    AppComponents.showSnackBar(
                        'Payment failed, please try again',
                        AppColorsDarkTheme.redAppColor,
                        context);
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
