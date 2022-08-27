import 'package:dio/dio.dart';
import 'package:ferdinand_coffee/model/points_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../components/easyloading.dart';
import '../../components/fluttertoast.dart';
import '../../pages/login/login.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';

class AcceptTasksApi {
  Future rejectTask(String taskId, String? point, BuildContext context) async {
    try {
      EasyLoadingIndicator.showProgres();
      String? token = await AccessToken.getToken();
      if (token != 'Bearer null') {
        NetworkProvider httpRequest = NetworkProvider(authToken: token);
        Response response = await httpRequest.call(
            '/admin/accept-task/$taskId', RequestMethod.post,
            data: {"point": point});
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
