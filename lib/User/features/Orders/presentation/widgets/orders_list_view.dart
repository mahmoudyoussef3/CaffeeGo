import 'package:coffe_app/User/features/Orders/presentation/widgets/user_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../Admin/Features/Orders/Presentation/widgets/admin_order_card.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../Data/models/order_model.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, required this.orders});
  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: UserOrderCard(
                admin: false,
                userName: "${index + 1}",
                totalPrice: order.orderTotalPrice,
                items: order.myOrders
                    .map((item) => {
                          "name": item.name,
                          "quantity": item.quantityInCart,
                          'price': item.sizes[item.selectedSize]
                        })
                    .toList(),
                orderDate: order.orderStartDate,
                orderStatus: order.stateOfTheOrder,
                qrWidget: qrWidget(),
                onScanQr: () => onScanQr(order, context)),
          );
        },
      ),
    );
  }

  Widget qrWidget() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'QR Code',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Icon(
          Icons.qr_code,
          color: Colors.white,
          size: 14,
        ),
      ],
    );
  }

  onScanQr(OrderModel order, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColorsDarkTheme.whiteAppColor,
          content: SizedBox(
            height: 200.h,
            width: 100.w,
            child: QrImageView(
                data:
                    "${order.userDataClass.name ?? 'UnKnownUser'} \n${order.myOrders.map((item) => "${item.name} - ${item.quantityInCart} - ${item.selectedSize}").toString()} "),
          ),
        );
      },
    );
  }
}
