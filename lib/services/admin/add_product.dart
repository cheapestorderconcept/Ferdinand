import 'package:dio/dio.dart';

import '../../components/fluttertoast.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../components/easyloading.dart';

class AddProductToStore {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future addProduct(
      String? productName,
      String? productPrice,
      String? productPictures,
      List<Map<String, dynamic>>? productVariants,
      String? productDescription,
      String? aboutProduct,
      String? vat,
      context) async {
    try {
      EasyLoadingIndicator.showProgres();
      NetworkProvider httpRequest =
          NetworkProvider(authToken: await AccessToken.getToken());
      await httpRequest.call('/admin/add-products', RequestMethod.post, data: {
        'product_name': productName,
        'product_categories': 'Fashion',
        "product_variants": productVariants,
        'product_pictures': productPictures,
        'product_description': productDescription,
        'about_product': aboutProduct,
        "vat": double.parse("$vat") / 100,
      });
      displayToast(
          Colors.green, Colors.white, 'Product successfully added to store');
      Navigator.pop(context);
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}

class UpdateProductapi {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future updateProduct(
      String? productId,
      String? productName,
      List<Map<String, dynamic>> productVariants,
      String? productDescription,
      String? productImage,
      String? productVat,
      context) async {
    try {
      String token = await AccessToken.getToken();
      EasyLoadingIndicator.showProgres();
      NetworkProvider httpRequest = NetworkProvider(authToken: token);
      Response response = await httpRequest
          .call('/admin/update-product/$productId', RequestMethod.put, data: {
        'product_name': productName,
        'product_variants': productVariants,
        "product_image": productImage,
        // "about_product": aboutProduct,
        'product_description': productDescription,
        "vat": productVat
      });
      String? message = response.data["response_message"];
      displayToast(Colors.green, Colors.white, '$message');
      Navigator.pop(context);
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}

class DeleteProductapi {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future deleteProduct(String? productId, context) async {
    try {
      String token = await AccessToken.getToken();
      EasyLoadingIndicator.showProgres();
      NetworkProvider httpRequest = NetworkProvider(authToken: token);
      Response response = await httpRequest.call(
          '/admin/delete-product/$productId', RequestMethod.delete);
      String? message = response.data["response_message"];
      displayToast(Colors.green, Colors.white, '$message');
      Navigator.pop(context);
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
