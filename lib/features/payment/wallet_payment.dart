import 'package:dio/dio.dart';

class PaymobWalletManager {
  Future<String> getPaymentKeyForWallet(
      int amount, String currency, String walletMobileNumber) async {
    try {
      // Step 1: Get Authentication Token
      String authenticationToken = await _getAuthenticationToken();

      // Step 2: Get Order ID
      int orderId = await _getOrderId(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
      );

      // Step 3: Get Payment Key
      String paymentKey = await _getPaymentKey(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
        orderId: orderId.toString(),
      );

      // Step 4: Pay With Wallet
      String redirectUrl = await _payWithWallet(
          paymentKey: paymentKey, walletMobileNumber: walletMobileNumber);

      // Step 5: Return Redirect URL
      return redirectUrl;
    } catch (e) {
      throw Exception("Wallet Payment Failed: ${e.toString()}");
    }
  }

  // Step 1: Get Authentication Token
  Future<String> _getAuthenticationToken() async {
    final Response response =
        await Dio().post("https://accept.paymob.com/api/auth/tokens", data: {
      "api_key":
          'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBeE16RXlNaXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS42ZmcteW4tUUgyZFU4eUdnTlVhU2ItUmJiQy1jSXN1M3FlRXk1M2NUa2lVQmdJMTZYMWdiaXh2dlY1bVdEQVhHbVVoVGJCcHNhREF4aFM4SmpLaGhodw==',
    });
    return response.data["token"];
  }

  // Step 2: Get Order ID
  Future<int> _getOrderId({
    required String authenticationToken,
    required String amount,
    required String currency,
  }) async {
    final Response response = await Dio()
        .post("https://accept.paymob.com/api/ecommerce/orders", data: {
      "auth_token": authenticationToken,
      "amount_cents": amount,
      "currency": currency,
      "delivery_needed": "true",
      "items": [],
    });
    return response.data["id"];
  }

  // Step 3: Get Payment Key
  Future<String> _getPaymentKey({
    required String authenticationToken,
    required String orderId,
    required String amount,
    required String currency,
  }) async {
    final Response response = await Dio()
        .post("https://accept.paymob.com/api/acceptance/payment_keys", data: {
      "expiration": 3600,
      "auth_token": authenticationToken,
      "order_id": orderId,
      "integration_id": 4904481, // Wallet Integration ID
      "amount_cents": amount,
      "currency": currency,
      "billing_data": {
        "first_name": "Mahmoud",
        "last_name": "Youssef",
        "email": "mahmoudyousse220@gmail.com",
        "phone_number": "01204154971",
        "city": "Cairo",
        "country": "Egypt",
      },
    });
    return response.data["token"];
  }

  // Step 4: Pay With Wallet
  Future<String> _payWithWallet({
    required String paymentKey,
    required String walletMobileNumber,
  }) async {
    final Response response = await Dio().post(
      "https://accept.paymob.com/api/acceptance/payments/pay",
      data: {
        "source": {
          "identifier": walletMobileNumber, // Mobile number linked to wallet
          "subtype": "WALLET",
        },
        "payment_token": paymentKey,
      },
    );

    // Check if redirect URL exists

    // Extract the redirect URL from the response
    String redirectUrl = response.data['redirect_url'];
    return redirectUrl;
  }
}
