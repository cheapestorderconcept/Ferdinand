import 'package:dio/dio.dart';
import 'package:ferdinand_coffee/model/points_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../components/easyloading.dart';
import '../../components/fluttertoast.dart';
import '../../pages/login/login.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';

class ViewTasksApi {
  Future<PointsModel?> viewTask(BuildContext context) async {
    PointsModel? model;
    try {
      EasyLoadingIndicator.showProgres();
      String? token = await AccessToken.getToken();
      if (token != 'Bearer null') {
        NetworkProvider httpRequest = NetworkProvider(authToken: token);
        Response response = await httpRequest.call(
          '/client/view-task',
          RequestMethod.get,
        );
        PointsModel pointsModel = PointsModel.fromJson(response.data["data"]);
        model = pointsModel;
      } else {
        Navigator.popAndPushNamed(context, LoginPage.routeName);
      }
    } catch (e) {
      displayToast(Colors.red, Colors.white, "$e");
    } finally {
      EasyLoading.dismiss();
    }
    return model;
  }
}
