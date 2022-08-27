import 'package:dio/dio.dart';
import '../../components/fluttertoast.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../components/easyloading.dart';

class SupportRequest {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future submitRequest(String? emailSubject, String? emailBody, context) async {
    try {
      EasyLoadingIndicator.showProgres();
      NetworkProvider httpRequest =
          NetworkProvider(authToken: await AccessToken.getToken());
      Response response = await httpRequest.call(
          '/client/support', RequestMethod.post,
          data: {'subject': emailSubject, 'message_body': emailBody});
      String? message = response.data["response_message"];
      displayToast(Colors.green, Colors.white, '$message');
      Navigator.pop(context);
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
