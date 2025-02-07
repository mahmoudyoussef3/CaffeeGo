import 'package:coffe_app/Admin/Features/Orders/Data/data_source/get_all_orders.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter/material.dart';
import '../../../../../features/Orders/Data/models/order_model.dart';
import '../../../../../features/home/data/models/UserData/user_data.dart';
import 'package:intl/intl.dart';

import '../../../AdminNotification/data/admin_notifications.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

final List<String> states = [
  'Pending',
  'In Progress',
  'Completed',
  'Cancelled'
];
String? selectedState;

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteAppColor,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.brownAppColor,
        elevation: 4,
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Select Order State:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      child: DropdownButton<String>(
                        value: selectedState,
                        hint: Text('Choose Order State'),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedState = newValue!;
                          });
                        },
                        items: states
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      foregroundColor:
                          WidgetStatePropertyAll(AppColors.brownAppColor)),
                  onPressed: selectedState != null
                      ? () async {
                          await GetAllOrders().changeTheStateOfTHeOrder(
                              selectedState!, widget.order.orderId);
                          await GetAllOrders()
                              .changeTheStateOfTHeOrderInUserCollection(
                                  selectedState!,
                                  widget.order.userDataClass.uuid!,
                                  widget.order.orderId);

                          OneSignalAdmin().sendNotificationToSpecificUser(
                              title: 'title',
                              message: 'message',
                              userId: widget.order.userDataClass.uuid!);
                        }
                      : null,
                  child: Text('Update Order State'),
                ),
              ],
            ),
            SizedBox(height: 12),
            _buildSectionCard(
              title: "Customer Info",
              child: _buildUserInfo(widget.order.userDataClass),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: "Order Details",
              child: _buildOrderInfo(widget.order),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: "Items Ordered",
              child: _buildOrderItems(widget.order.myOrders),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: "User Requirements",
              child: _buildUserInfo(widget.order.userDataClass),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.brownAppColor,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildUserInfo(UserDataClass userData) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading:
          const Icon(Icons.person, color: AppColors.brownAppColor, size: 30),
      title: Text(
        userData.name!,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email: ${userData.email}",
              style: const TextStyle(fontSize: 16)),
          Text(
              "Phone: ${userData.phoneNumber!.isNotEmpty ? userData.phoneNumber : 'No phone number provided'}",
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildOrderInfo(OrderModel order) {
    String formattedDate =
        DateFormat('MMM d, yyyy - hh:mm ').format(order.orderStartDate);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.shopping_cart,
          color: AppColors.brownAppColor, size: 30),
      title: Text(
        "Total Price: \$${order.orderTotalPrice}",
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Status: ${order.stateOfTheOrder}",
              style: const TextStyle(fontSize: 16)),
          Text("Date: $formattedDate",
              style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildOrderItems(List<CoffeeItem> orders) {
    return Column(
      children: orders.map((order) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(Icons.local_cafe,
                  color: AppColors.brownAppColor, size: 30),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      order.description,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${order.sizes[order.selectedSize]}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUserRequirements() {
    return Text("User Requirements",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }
}
