import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/features/home/data/models/UserData/user_data.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:uuid/uuid.dart';

class OrderModel {
  String orderId;
  final List<CoffeeItem> myOrders;
  String stateOfTheOrder;
  String orderTotalPrice;
  DateTime orderStartDate;
  UserDataClass userDataClass;
  String paymentMethod;
  bool paymentProcess;
  String userRequirements;

  OrderModel(
      {required this.myOrders,
      required this.stateOfTheOrder,
      required this.orderTotalPrice,
      required this.orderStartDate,
      required this.userDataClass,
      required this.paymentMethod,
      required this.paymentProcess,
      required this.userRequirements,
      String? orderId})
      : orderId = orderId ?? Uuid().v4();

  factory OrderModel.fromJson(Map<String, dynamic> myData) {
    return OrderModel(
        userRequirements: myData['userRequirements'] ?? 'No Requirements',
        orderId: myData['orderId'] ?? Uuid().v4(),
        myOrders: (myData['orders'] as List<dynamic>?)
                ?.map(
                    (data) => CoffeeItem.fromMap(data as Map<String, dynamic>))
                .toList() ??
            [],
        stateOfTheOrder: myData['stateOfTheOrder'],
        orderTotalPrice: myData['orderTotalPrice'] ?? '0',
        paymentMethod: myData['paymentMethod'],
        paymentProcess: myData['paymentProcess'] ?? false,
        userDataClass: UserDataClass.fromJson(myData['userData']),
        orderStartDate: (myData['orderStartDate'] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orders': myOrders.map((item) => item.toMap()).toList(),
      'stateOfTheOrder': stateOfTheOrder,
      'orderTotalPrice': orderTotalPrice,
      'orderStartDate': orderStartDate.toUtc(),
      'userData': userDataClass.toJson(),
      'paymentMethod': paymentMethod,
      'paymentProcess': paymentProcess,
      'userRequirements': userRequirements,
    };
  }
}
