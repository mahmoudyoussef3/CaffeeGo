import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {

                Navigator.pushNamed(context, AppStrings.itemDetails);
              },
              child: Text('Go to Details'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Home Screen
                Navigator.pop(context);
              },
              child: Text('Go back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
