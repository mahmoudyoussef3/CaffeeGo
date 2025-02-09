import 'package:flutter/material.dart';

import '../widgets/best_selling_chart.dart';
import '../widgets/earnings_chart.dart';
import '../widgets/orders_perHour_chart.dart';
import '../widgets/payment_method_pie_chart.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📊 Dashboard'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            DashboardCard(
              title: 'إجمالي الأرباح',
              icon: Icons.attach_money,
              color: Colors.green,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(body: EarningsChart()),
                  )),
            ),
            DashboardCard(
              title: 'عدد الطلبات',
              icon: Icons.shopping_cart,
              color: Colors.blue,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(body: OrdersPerHourChart()),
                  )),
            ),
            DashboardCard(
              title: 'أفضل المنتجات',
              icon: Icons.star,
              color: Colors.orange,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(body: BestSellingChart()),
                  )),
            ),
            DashboardCard(
                title: 'حالة الطلبات',
                icon: Icons.timeline,
                color: Colors.purple,
                onTap: () {}),
            DashboardCard(
              title: 'طرق الدفع',
              icon: Icons.payment,
              color: Colors.red,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Scaffold(body: PaymentMethodPieChart()),
                  )),
            ),
            DashboardCard(
                title: 'ساعات الذروة',
                icon: Icons.access_time,
                color: Colors.teal,
                onTap: () => {}),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  DashboardCard(
      {required this.title,
      required this.icon,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
