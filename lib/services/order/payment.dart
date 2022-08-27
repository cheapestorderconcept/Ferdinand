import 'package:dio/dio.dart';
import '../../components/easyloading.dart';
import '../../components/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../pages/login/login.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentApi {
  Future<String?> initiatePayment(num total, String? promoCode,
      String? redeemPoints, BuildContext context) async {
    String? clientSecret;
    try {
      String? token = await AccessToken.getToken();

      if (token != "Bearer null") {
        NetworkProvider httpRequest = NetworkProvider(authToken: token);
        EasyLoadingIndicator.showProgres();
        Response response = await httpRequest.call(
            '/client/initiate-payment', RequestMethod.post, data: {
          "total_amount": total,
          "discount_code": promoCode,
          "user_points": redeemPoints
        });
        clientSecret = response.data["data"]["client_secret"];
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: clientSecret,
              googlePay: true,
              applePay: true,
              customerId: null,
              style: ThemeMode.dark,
              merchantDisplayName: "Ferdinand Coffee",
              currencyCode: "CHF",
              merchantCountryCode: "US"),
        );
      } else {
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const LoginPage()),
          ModalRoute.withName(LoginPage.routeName),
        );
      }
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
    return clientSecret;
  }
}

class PaymentSheet {
  Future<bool> displayPaymentSheet(context) async {
    bool hasPaid = false;
    try {
      await Stripe.instance.presentPaymentSheet();
      hasPaid = true;
    } catch (e) {
      displayToast(Colors.red, Colors.white,
          AppLocalizations.of(context)!.incompletePayment);
    }
    return hasPaid;
  }
}
