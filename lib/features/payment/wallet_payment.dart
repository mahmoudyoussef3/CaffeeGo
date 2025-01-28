import 'dart:convert';

import 'package:dio/dio.dart';

class PayMobWalletManager {
  final String apiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBeE56RXpPQ3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5qZUdnSnk1b2NRcUtpN1Y0SXExS0FTcGVvWm5VM2lKU1hYV0t0cnNpVUlSMy1rSm01WjhtcTkwNGdyckZ4eVFpaUc5Z0o0UFlKUXB1Z19IUHg2cWh4Zw==';
  final Dio _dio = Dio();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  Future<String> getPaymentKeyForWallet(
      int amount, String walletMobileNumber) async {
    try {
      String authenticationToken = await _getAuthenticationToken();
      print('authenticationToken: ' + authenticationToken);

      int orderId = await _getOrderId(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString(),
      );
      print('orderId: $orderId');

      String paymentKey = await _getPaymentKey(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString(),
        orderId: orderId.toString(),
      );
      print('paymentKey: $paymentKey');

      // Step 4: Pay With Wallet
      String redirectUrl = await _payWithWallet(
        authToken: authenticationToken,
          paymentKey: paymentKey, walletMobileNumber: walletMobileNumber);
      print('Redirect URL: $redirectUrl');

      return redirectUrl;
    } catch (e) {
      throw Exception("Wallet Payment Failed: ${e.toString()}");
    }
  }

  Future<String> _getAuthenticationToken() async {
    try {
      final Response response = await _dio.post(
        "https://accept.paymob.com/api/auth/tokens",
        data: {"api_key": apiKey},
        options: Options(headers: _headers),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data['token']);
        return response.data["token"];
      } else {
        throw Exception("Failed to get authentication token.");
      }
    } catch (e) {
      throw Exception("Error in getting authentication token: ${e.toString()}");
    }
  }

  Future<int> _getOrderId({
    required String authenticationToken,
    required String amount,
  }) async {
    try {
      final Response response = await _dio.post(
        "https://accept.paymob.com/api/ecommerce/orders",
        data: {
          "auth_token": authenticationToken,
          "amount_cents": amount,
          'currency': 'EGP',
          "delivery_needed": "true",
          "items": [],
        },
        options: Options(headers: _headers),
      );
      if (response.statusCode == 201 && response.data["id"] != null) {
        print(response.data['id']);
        return response.data["id"];
      } else {
        throw Exception("Failed to get order ID.");
      }
    } catch (e) {
      throw Exception("Error in getting order ID: ${e.toString()}");
    }
  }

  Future<String> _getPaymentKey({
    required String authenticationToken,
    required String orderId,
    required String amount,
  }) async {
    try {
      final Response response = await _dio.post(
        "https://accept.paymob.com/api/acceptance/payment_keys",
        data: {
          "auth_token": authenticationToken,
          "order_id": orderId,
          "integration_id": '4923809',
          "amount_cents": amount,
          'currency': 'EGP',
          'billing_data': {
            'apartment': 'NA',
            'email': 'john.doe@example.com',
            'floor': 'NA',
            'first_name': 'John',
            'street': 'NA',
            'building': 'NA',
            'phone_number': '+201204154971',
            'shipping_method': 'NA',
            'postal_code': 'NA',
            'city': 'Cairo',
            'country': 'EG',
            'last_name': 'Doe',
            'state': 'NA',
          },
        },
        options: Options(headers: _headers),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["token"]);
        return response.data["token"];
      } else {
        throw Exception("Failed to get payment key.");
      }
    } catch (e) {
      throw Exception("Error in getting payment key: ${e.toString()}");
    }
  }

  // Step 4: Pay With Wallet
  Future<String> _payWithWallet({
    required String paymentKey,
    required String walletMobileNumber,
    required String authToken,
  }) async {
    try {
      final Response response = await _dio.post(
        "https://accept.paymob.com/api/acceptance/payments/pay",
        data: {
          "source": {
            "identifier": walletMobileNumber,
            "subtype": "WALLET",
          },
          "payment_token": paymentKey,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        String redirectUrl = response.data['redirect_url'];
        print(response.data);
        print(response.statusCode);
        return redirectUrl;
      } else {
        throw Exception("Failed to process payment with wallet.");
      }
    } catch (e) {
      throw Exception("Error in payment with wallet: ${e.toString()}");
    }
  }
}
