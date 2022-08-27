import 'package:dio/dio.dart';
import '../../components/easyloading.dart';
import '../../components/fluttertoast.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UpdateClientOrder {
  Future<void> updateOrder(String? orderId, String? trackingNumber,
      String? logisticName, String? status, String? arrivalDate) async {
    try {
      EasyLoadingIndicator.showProgres();
      NetworkProvider httpRequest =
          NetworkProvider(authToken: await AccessToken.getToken());
      Response response = await httpRequest.call(
          '/admin/update-client-order?orderId=$orderId', RequestMethod.put,
          data: {
            "tracking_number": trackingNumber,
            "order_status": status,
            "arrived_by": arrivalDate,
            "logistic_name": logisticName
          });
      String? message = response.data["response_message"];
      displayToast(Colors.green, Colors.white, '$message');
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
