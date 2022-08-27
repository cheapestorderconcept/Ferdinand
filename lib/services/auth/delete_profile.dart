import 'package:dio/dio.dart';

import '../../components/fluttertoast.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../components/easyloading.dart';

class DeleteProfile {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future deleteRequest(context) async {
    String? token = await AccessToken.getToken();

    try {
      if (token != "Bearer null") {
        EasyLoadingIndicator.showProgres();
        NetworkProvider httpRequest = NetworkProvider(authToken: token);
        Response response = await httpRequest.call(
          '/client/delete-profile',
          RequestMethod.delete,
        );
        String? message = response.data["response_message"];
        displayToast(Colors.green, Colors.white, '$message');
        //TODO: Navigate user to the login page
        // Navigator.popUntil(context, ModalRoute.withName(LoginPage.route));
      } else {
        // Navigator.popAndPushNamed(context, LoginPage.route);
        displayToast(Colors.red, Colors.white, 'Please login to continue');
      }
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
