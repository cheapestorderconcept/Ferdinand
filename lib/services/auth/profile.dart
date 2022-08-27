import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../../components/fluttertoast.dart';
import '../../model/Profile.dart';

import '../../pages/login/login.dart';
import '../../provider/profile_provider.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../components/easyloading.dart';

class UserProfileApi {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future userProfile(BuildContext context) async {
    try {
      EasyLoadingIndicator.showProgres();
      String? token = await AccessToken.getToken();
      NetworkProvider httpRequest = NetworkProvider(authToken: token);
      Response response = await httpRequest.call(
        '/client/profile',
        RequestMethod.get,
      );

      ProfileModel profileModel =
          ProfileModel.fromJson(response.data["data"]["user"]);
      var resProvider = Provider.of<ProfileProvider>(context, listen: false);
      resProvider.setProfile = profileModel;
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}

class UpdateUserProfileApi {
  Future updateProfile(Map<String, dynamic>? data, BuildContext context) async {
    try {
      EasyLoadingIndicator.showProgres();
      String? token = await AccessToken.getToken();
      if (token != "Bearer null") {
        NetworkProvider httpRequest = NetworkProvider(authToken: token);
        Response response = await httpRequest.call(
            '/client/update-profile', RequestMethod.put,
            data: {"data": data});
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
