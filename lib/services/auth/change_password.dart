import 'package:dio/dio.dart';
import '../../components/fluttertoast.dart';
import '../../pages/login/login.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../components/easyloading.dart';

class ChangePasswordApi {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future changePassword(
      String? oldPassword, String? password, String? cPassword, context) async {
    String? token = await AccessToken.getToken();
    try {
      if (token != "Bearer null") {
        EasyLoadingIndicator.showProgres();
        NetworkProvider httpRequest =
            NetworkProvider(authToken: await AccessToken.getToken());
        Response response = await httpRequest
            .call('/client/change-password', RequestMethod.post, data: {
          'old_password': oldPassword,
          'new_password': password,
          'confirm_password': cPassword
        });
        String? message = response.data["response_message"];
        displayToast(Colors.green, Colors.white, '$message');
        Navigator.pop(context);
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
  }
}
