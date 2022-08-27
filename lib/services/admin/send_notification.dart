import 'package:dio/dio.dart';
import 'package:ferdinand_coffee/utils/network/accesstoken.dart';

import '../../components/fluttertoast.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';

class SendNotificationApi {
  Future notification(String? message) async {
    try {
      String? token = await AccessToken.getToken();
      NetworkProvider httpRequest = NetworkProvider(authToken: token);

      Response response = await httpRequest.call(
          '/admin/send-notification', RequestMethod.post,
          data: {"message": message});
      String? res = response.data["response_message"];
      displayToast(Colors.green, Colors.white, "$res");
    } catch (e) {
      displayToast(Colors.green, Colors.white, "$e");
    }
  }
}
