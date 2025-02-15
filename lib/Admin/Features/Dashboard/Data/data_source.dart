import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardAnalysis {
  /// This function works good
  Future<double> getTotalEarnings(DateTime date) async {
    try {
      final startOfDay = Timestamp.fromDate(
          DateTime(date.year, date.month, date.day, 0, 0, 0));
      final endOfDay = Timestamp.fromDate(
          DateTime(date.year+5, date.month, date.day, 23, 59, 59));

      var querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('order.orderStartDate', isGreaterThanOrEqualTo: startOfDay)
          .where('order.orderStartDate', isLessThanOrEqualTo: endOfDay)
          .where('order.stateOfTheOrder', isEqualTo: "Completed")
          .get();

      double totalEarnings = 0.0;

      for (var doc in querySnapshot.docs) {
        // totalEarnings += doc['order.orderTotalPrice'];
        var price = doc['order.orderTotalPrice'];
        if (price is String) {
          totalEarnings += double.tryParse(price) ?? 0.0;
        } else if (price is num) {
          totalEarnings += price.toDouble();
        }
      }
      print("Total earnings for $date: $totalEarnings");

      return totalEarnings;
    } catch (e) {
      print("Error while getting total earnings: $e");
      return 0.0;
    }
  }

  ///This function works good
  Future<Map<String, int>> getOrderStatusCount() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('orders').get();

      int completed = 0;
      int canceled = 0;
      int pending = 0;
      int inProgress = 0;

      for (var doc in querySnapshot.docs) {
        if (doc['order.stateOfTheOrder'] == 'Completed') {
          completed++;
        } else if (doc['order.stateOfTheOrder'] == 'Cancelled') {
          canceled++;
        } else if (doc['order.stateOfTheOrder'] == 'Pending') {
          pending++;
        } else if (doc['order.stateOfTheOrder'] == 'In Progress') {
          inProgress++;
        }
      }
      print({
        "Completed": completed,
        "Canceled": canceled,
        "In Progress": inProgress,
        "Pending": pending
      });

      return {
        "Completed": completed,
        "Canceled": canceled,
        "In Progress": inProgress,
        "Pending": pending
      };
    } catch (e) {
      print("Error while getting order status count: $e");
      return {};
    }
  }

  ///This function works good
  Future<Map<String, num>> getBestSellingItems() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('orders').get();

      Map<String, num> productCounts = {};

      for (var doc in querySnapshot.docs) {
        for (var item in doc['order.orders']) {
          String itemName = item['name'];
          productCounts[itemName] =
              (productCounts[itemName] ?? 0) + item['quantity'];
        }
      }
      print(productCounts);

      return productCounts;
    } catch (e) {
      print("Error while getting best selling items: $e");
      return {};
    }
  }

  Future<Map<int, int>> getOrdersPerHour() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('orders').get();

      Map<int, int> hoursCount = {};

      for (var doc in querySnapshot.docs) {
        DateTime time = (doc['order.orderStartDate'] as Timestamp).toDate();
        int hour = time.hour;
        hoursCount[hour] = (hoursCount[hour] ?? 0) + 1;
      }
      print(hoursCount);

      return hoursCount;
    } catch (e) {
      print("Error while getting orders per hour: $e");
      return {};
    }
  }

  ///This function works good
  Future<Map<String, int>> getPaymentMethodStats() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('orders').get();

      int onlinePayments = 0;
      int cashPayments = 0;

      for (var doc in querySnapshot.docs) {
        if (doc['order.paymentMethod'] == 'Paymob') {
          onlinePayments++;
        } else if (doc['order.paymentMethod'] == 'Cash') {
          cashPayments++;
        }
      }
      print({"online": onlinePayments, "cash": cashPayments});

      return {"online": onlinePayments, "cash": cashPayments};
    } catch (e) {
      print("Error while getting payment method stats: $e");
      return {};
    }
  }
}
