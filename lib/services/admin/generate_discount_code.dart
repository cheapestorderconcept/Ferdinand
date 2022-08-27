import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import '../../components/easyloading.dart';
import '../../components/fluttertoast.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GeneratePromoCodeApi {
  Future generateCode(
      String? percentageOff, String? discountName, BuildContext context) async {
    String? token = await AccessToken.getToken();
    NetworkProvider httpRequest = NetworkProvider(authToken: token);
    try {
      EasyLoadingIndicator.showProgres();
      if (token != "Bearer null") {
        Response response = await httpRequest.call(
            '/admin/promo-code', RequestMethod.post,
            data: {"percentage": percentageOff, 'discount_name': discountName});
        displayToast(
            Colors.green, Colors.white, response.data["response_message"]);
      }
    } catch (e) {
      displayToast(Colors.red, Colors.white, "$e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}

class GetPromoCodeApi {
  Future getCode(BuildContext context) async {
    String? token = await AccessToken.getToken();
    NetworkProvider httpRequest = NetworkProvider(authToken: token);
    try {
      EasyLoadingIndicator.showProgres();
      if (token != "Bearer null") {
        Response response = await httpRequest.call(
          '/client/get-code',
          RequestMethod.get,
        );
        AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.LEFTSLIDE,
          title: 'Discount Code',
          desc: response.data["response_message"],
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      }
    } catch (e) {
      displayToast(Colors.red, Colors.white, "$e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}

class ExpiredCode {
  Future expiredCode() async {
    try {
      String? token = await AccessToken.getToken();
      NetworkProvider httpRequest = NetworkProvider(authToken: token);
      Response response =
          await httpRequest.call('/admin/expired-code', RequestMethod.delete);
      String? message = response.data["response_message"];
      displayToast(Colors.green, Colors.white, "$message");
    } catch (e) {
      displayToast(Colors.red, Colors.white, "$e");
    }
  }
}
