import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/fluttertoast.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../components/easyloading.dart';

class SignupUser {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future signAuth(String? email, String? password, String? firstName,
      String? lastName, String? phoneNumber, String? refID) async {
    final prefs = await SharedPreferences.getInstance();
    bool? isEnglish = prefs.getBool("isEnglish");
    try {
      EasyLoadingIndicator.showProgres();
      NetworkProvider httpRequest = NetworkProvider();
      Response response =
          await httpRequest.call('/client/signup', RequestMethod.post, data: {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        "referral_id": refID,
        "phone_number": phoneNumber,
        "language": isEnglish != null && isEnglish == true ? "en" : "DE"
      });
      String token = response.data['data']['token'];
      String role = response.data['data']['newUser']['role'];
      await storage.write(key: 'token', value: token);
      String? message = response.data["response_message"];
      displayToast(Colors.green, Colors.white, '$message');
      if (role != 'client') {}
      return response;
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
