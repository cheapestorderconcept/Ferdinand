import 'package:dio/dio.dart';
import 'package:ferdinand_coffee/pages/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/fluttertoast.dart';
import '../../model/Profile.dart';
import '../../provider/profile_provider.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../components/easyloading.dart';

class Loginuser {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future loginAuth(String? email, String? password, context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool? isEnglish = prefs.getBool("isEnglish");
      EasyLoadingIndicator.showProgres();
      NetworkProvider httpRequest = NetworkProvider();
      Response response = await httpRequest.call(
        '/client/login',
        RequestMethod.post,
        data: {
          'email': email,
          'password': password,
          "language": isEnglish != null && isEnglish == true ? "en" : "DE"
        },
      );
      String token = response.data['data']['token'];
      ProfileModel profileModel =
          ProfileModel.fromJson(response.data["data"]["existingUser"]);
      var resProvider = Provider.of<ProfileProvider>(context, listen: false);
      resProvider.setProfile = profileModel;

      await storage.write(key: 'token', value: token);
      if (resProvider.myprofileModel?.role == 'client') {
        prefs.setBool("loggedIn", true);
        Navigator.popAndPushNamed(context, HomePage.routeName);
      } else {
        Navigator.popAndPushNamed(context, HomePage.routeName);
        prefs.setBool("loggedIn", true);
      }
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
