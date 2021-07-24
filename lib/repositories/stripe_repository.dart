import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeRepository {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeRepository.apiBase}/payment_intents';
  static Uri paymentApiUri = Uri.parse(paymentApiUrl);
  static String secret =
      'sk_test_51IybLKAW5XQBJRRQle5jA6kFuQVujWfugyTsnkedVjWB7bRtTSGKQ6l7SO4QLgvg7RgJY07uILVutwTXE70G9yYC00N1RtFB51';

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeRepository.secret}',
    'Content-type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            'pk_test_51IybLKAW5XQBJRRQZdW4WIxaX6g23LLvG9kZCiiSWEurPy2WvS0r7IZ9iNzoI9Er75BQT2oF4UBS7XXbM9DMlEui00t2kuCkyn',
        merchantId: 'test',
        androidPayMode: 'test'));
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {required String amount, required String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      /*var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed', success: false)      

    */
      return StripeTransactionResponse(
          message: 'Transaction successful', success: true);
    } on PlatformException catch (error) {
      return StripeTransactionResponse(
          message: error.message ?? 'error',
          success:
              false); //StripeService.getPlatformExceptionErrorResult(error);
    } catch (error) {
      return StripeTransactionResponse(
          message: 'Transaction failed : $error', success: false);
    }
  }
}

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({required this.message, required this.success});
}
