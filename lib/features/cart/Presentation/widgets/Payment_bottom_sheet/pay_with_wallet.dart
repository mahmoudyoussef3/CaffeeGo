import 'package:flutter/material.dart';

class PayWithWallet extends StatelessWidget {
  const PayWithWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement Mobile Wallet payment logic
      },
      child: Container(
        width: 130,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green,
        ),
        child: const Center(
          child: Text(
            'Mobile Wallet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
