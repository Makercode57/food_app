import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;

  void init({
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
    required VoidCallback onExternalWallet,
  }) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (res) => onSuccess());
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (res) => onFailure());
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (res) => onExternalWallet());
  }

  void openCheckout({
    required int amount,
    required String name,
    required String description,
    required String email,
    required String contact,
  }) {
    var options = {
      'key': 'rzp_test_YourKeyHere',
      'amount': amount * 100, 
      'name': name,
      'description': description,
      'prefill': {
        'contact': contact,
        'email': email,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}
