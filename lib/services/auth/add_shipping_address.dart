import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../../components/fluttertoast.dart';

import '../../model/shipping_address.dart';
import '../../pages/login/login.dart';
import '../../provider/shipping_address_provider.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../components/easyloading.dart';

class AddShippingAddressApi {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future postAddress(String? firstName, String? lastName, String? city,
      String? zipCode, String? phoneNumber, String? landRegion, context) async {
    String? token = await AccessToken.getToken();
    print(city);
    try {
      if (token != "Bearer null") {
        EasyLoadingIndicator.showProgres();
        NetworkProvider httpRequest = NetworkProvider(authToken: token);
        Response response = await httpRequest
            .call('/client/add-shipping-address', RequestMethod.post, data: {
          'phone_number': phoneNumber,
          'first_name': firstName,
          'last_name': lastName,
          'address': city,
          "zip_code": zipCode,
          "land_region": landRegion
        });
        String? message = response.data["response_message"];
        displayToast(Colors.green, Colors.white, '$message');
        Navigator.pop(context);
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
  }
}

class GetShippingAddress {
  Future getShippingAddress(BuildContext context) async {
    try {
      NetworkProvider httpRequest =
          NetworkProvider(authToken: await AccessToken.getToken());
      Response response = await httpRequest.call(
          '/client/view-shipping-info', RequestMethod.get);
      ShippingAddressModel model =
          ShippingAddressModel.fromJson(response.data["data"]);
      var resProvider =
          Provider.of<ShippingAddressProvider>(context, listen: false);
      resProvider.userShippingAddress = model.shippingAddress;
    } catch (e) {}
  }
}
