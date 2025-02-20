import 'package:coffe_app/Admin/main_admin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../User/features/Orders/Data/models/order_model.dart';
import '../../../../../User/features/home/data/models/UserData/user_data.dart';
import '../../../../../User/features/home/data/models/coffe_item.dart';
import '../../../../../config/notifications.dart/send_notification_srevice.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/components/app_components.dart';
import '../../../AdminNotification/data/admin_notifications.dart';
import '../../Data/data_source/get_all_orders.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final List<String> states = [
    'Pending',
    'In Progress',
    'Completed',
    'Cancelled'
  ];
  String? selectedState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteAppColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Order Details",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.brownAppColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionCard(
              title: "Customer Info",
              icon: Icons.person,
              child: _buildUserInfo(widget.order.userDataClass),
            ),
            _buildSectionCard(
              title: "Items Ordered",
              icon: Icons.local_cafe,
              child: _buildOrderItems(widget.order.myOrders),
            ),
            _buildSectionCard(
              title: "User Requirements",
              icon: Icons.list,
              child: Text(
                  widget.order.userRequirements.isEmpty
                      ? 'No requirements'
                      : widget.order.userRequirements,
                  style: const TextStyle(fontSize: 16)),
            ),
            _buildSectionCard(
              title: "Order Details",
              icon: Icons.receipt_long,
              child: _buildOrderInfo(widget.order),
            ),
            const SizedBox(height: 20),
            _buildDropdown(),
            const SizedBox(height: 20),
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Order State:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: selectedState,
            hint: const Text('Choose State'),
            onChanged: (String? newValue) {
              setState(() {
                selectedState = newValue;
              });
            },
            items: states.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brownAppColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: selectedState != null ? _updateOrderState : null,
        child: const Text('Update Order State',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> _updateOrderState() async {
    await GetAllOrders()
        .changeTheStateOfTHeOrder(selectedState!, widget.order.orderId);
    AppComponents.showToastMsg('State updated Successfully!');
    Navigator.pushReplacementNamed(context, "/manageOrders");
    await GetAllOrders().changeTheStateOfTHeOrderInUserCollection(
      selectedState!,
      widget.order.userDataClass.uuid!,
      widget.order.orderId,
    );
    sendNotificationToUser(
        title: 'Order Update',
        body: 'Your order status has changed to $selectedState',
        data: {},
        token: widget.order.userDataClass.fcmToken ?? '');
  }

  Widget _buildSectionCard(
      {required String title, required IconData icon, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(), blurRadius: 10, spreadRadius: 2)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.brownAppColor),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(height: 20, thickness: 1.2, color: Colors.black12),
          child,
        ],
      ),
    );
  }

  Widget _buildUserInfo(UserDataClass userData) {
    return ListTile(
      title: Text(userData.name!,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text("Email: ${userData.email}"),
    );
  }

  Widget _buildOrderInfo(OrderModel order) {
    String formattedDate =
        DateFormat('MMM d, yyyy - hh:mm a').format(order.orderStartDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Total: \$${order.orderTotalPrice}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("Payment: ${order.paymentProcess ? 'Done' : 'Not paid'}"),
        Text("Status: ${order.stateOfTheOrder}"),
        Text("Date: $formattedDate"),
      ],
    );
  }

  Widget _buildOrderItems(List<CoffeeItem> orders) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: orders.map((order) {
        return ListTile(
          title: Text(order.name,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Text(order.description),
          trailing: Text("\$${order.sizes[order.selectedSize]}",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        );
      }).toList(),
    );
  }
}
