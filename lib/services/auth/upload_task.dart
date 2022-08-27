import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../components/easyloading.dart';
import '../../components/fluttertoast.dart';
import '../../pages/login/login.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';

class UploadTaskApi {
  Future upload(String? task, BuildContext context) async {
    try {
      EasyLoadingIndicator.showProgres();
      String? token = await AccessToken.getToken();
      if (token != 'Bearer null') {
        NetworkProvider httpRequest = NetworkProvider(authToken: token);
        Response response = await httpRequest.call(
            '/client/upload-task', RequestMethod.post,
            data: {"task": task});
        String? message = response.data["response_message"];
        displayToast(Colors.green, Colors.white, '$message');
      } else {
        Navigator.popAndPushNamed(context, LoginPage.routeName);
      }
    } catch (e) {
      displayToast(Colors.red, Colors.white, "$e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
