import 'package:dio/dio.dart';
import 'package:ferdinand_coffee/pages/login/login.dart';
import '../../components/easyloading.dart';
import '../../components/fluttertoast.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ImageUploader {
  Future uploadImage(String fileName, String imagePath, String fileType,
      String mimeType, BuildContext context) async {
    String? token = await AccessToken.getToken();
    String? imageKey;
    try {
      if (token != "Bearer null") {
        EasyLoadingIndicator.showProgres();
        NetworkProvider httpRequest =
            NetworkProvider(authToken: await AccessToken.getToken());
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            imagePath,
            filename: fileName,
            contentType: MediaType(fileType, mimeType),
          ),
        });
        Response response = await httpRequest.call(
            '/admin/upload-file/demo-bucket', RequestMethod.post,
            formData: formData);
        String message = response.data["response_message"];
        imageKey = response.data["data"]["Key"];
        displayToast(Colors.green, Colors.white, message);
        return imageKey;
      } else {
        displayToast(
            Colors.red, Colors.white, 'Bitte einloggen zum Fortfahren');
        Navigator.popAndPushNamed(context, LoginPage.routeName);
      }
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
