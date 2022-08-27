import 'package:dio/dio.dart';
import '../../components/easyloading.dart';
import '../../components/fluttertoast.dart';
import '../../pages/login/login.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddProductToFavoritesList {
  Future<Response?> addToFavorites(productId, BuildContext context) async {
    Response? response;
    String? token = await AccessToken.getToken();
    NetworkProvider httpRequest =
        NetworkProvider(authToken: await AccessToken.getToken());
    try {
      if (token != "Bearer null") {
        EasyLoadingIndicator.showProgres();
        response = await httpRequest.call(
            '/client/add-favorites', RequestMethod.post,
            data: {'product': productId});
        String? message = response.data["response_message"];
        displayToast(Colors.green, Colors.white, '$message');
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
    return response;
  }
}
