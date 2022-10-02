import 'package:dio/dio.dart';
import '../../components/easyloading.dart';
import '../../components/fluttertoast.dart';
import '../../model/client_order.dart';
import '../../pages/login/login.dart';
import '../../provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';

class PlaceOrder {
  Future placeOrder(
      List<Map<String, dynamic>> items, BuildContext context) async {
    try {
      String? token = await AccessToken.getToken();
      if (token == 'Bearer null') {
        Navigator.pushNamed(context, LoginPage.routeName);
      }
      NetworkProvider httpRequest =
          NetworkProvider(authToken: await AccessToken.getToken());
      EasyLoadingIndicator.showProgres();

      Response response = await httpRequest.call(
          '/client/place-order', RequestMethod.post,
          data: {"items": items});
      String? message = response.data["response_message"];
      displayToast(Colors.green, Colors.white, "$message");
      Provider.of<CartProvider>(context, listen: false).clearCart = {};
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}

class GetPlacedOrder {
  Future<ClientOrderModel?> placeOrder(BuildContext context) async {
    ClientOrderModel? clientOrderModel;
    String? loggedIn = await AccessToken.getToken();
    try {
      if (loggedIn != "Bearer null") {
        NetworkProvider httpRequest =
            NetworkProvider(authToken: await AccessToken.getToken());
        Response response =
            await httpRequest.call('/client/view-order', RequestMethod.get);
        clientOrderModel = ClientOrderModel.fromJson(response.data["data"]);
        Provider.of<CartProvider>(context, listen: false).clearCart = {};
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
    return clientOrderModel;
  }
}
