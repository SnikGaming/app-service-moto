import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paypal/flutter_paypal.dart';

class PayMentFunction {
  static Map<String, dynamic>? paymentIntent;

  static void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      var gpay = PaymentSheetGooglePay(
          merchantCountryCode: 'US', currencyCode: "US", testEnv: true);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: "LONG",
          googlePay: gpay,
        ),
      );
      displayPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  static void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Payment--> Done');
    } catch (e) {
      print(e);
      print('Payment--> Done');
    }
  }

  static createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {"amount": "1000", "currency": "US"};
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1PqupXDITMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPlq00wmjWwZYA",
            "Content-Type": "application/x-www-form-urlendcoded"
          });
      return json.decode(response.body);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  static PayPalMethod() {
    return UsePaypal(
      sandboxMode: true,
      clientId:
          "AQ-z5DPK42W8qrx7VSC2g2aF0PxY_Ko_KUYrNyxi4rlD_q9JY5c1muG1q9fSgRgHyjmc_eqPuGG0wX8S",
      secretKey:
          "EKOZxrCebxy9EYW6SzJM6TYBss8rJ1DaaikVSU6F39PKiNxAI9eLdAg0znnm3ku-Swqi3YcUEO8LnyBD",
      returnURL: "https://samplesite.com/return",
      cancelURL: "https://samplesite.com/cancel",
      transactions: const [
        {
          "amount": {
            "total": '0.01',
            "currency": "USD",
            "details": {
              "subtotal": '0.01',
              "shipping": '0',
              "shipping_discount": 0
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },

          //!:
          "item_list": {
            "items": [
              {
                "name": "A demo product",
                "quantity": 1,
                "price": '0.01',
                "currency": "USD"
              }
            ],

            // shipping address is not required though
            "shipping_address": {
              "recipient_name": "Jane Foster",
              "line1": "Travis County",
              "line2": "",
              "city": "Austin",
              "country_code": "US",
              "postal_code": "73301",
              "phone": "+00000000",
              "state": "Texas"
            },
          }
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {},
      onError: (error) {},
      onCancel: (params) {},
    );
  }
}
