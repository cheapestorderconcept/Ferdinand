import 'package:dio/dio.dart';
import 'package:ferdinand_coffee/provider/Favorites_product.dart';
import 'package:provider/provider.dart';
import '../../components/fluttertoast.dart';
import '../../model/favorites_list.dart';
import '../../pages/login/login.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../components/easyloading.dart';

class MyFavoritesProduct {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<FavoritesProductProvider?> getFavorites(context) async {
    FavoritesProductProvider? model;
    try {
      String? token = await AccessToken.getToken();
      if (token != "Bearer null") {
        EasyLoadingIndicator.showProgres();
        NetworkProvider httpRequest =
            NetworkProvider(authToken: await AccessToken.getToken());
        Response response = await httpRequest.call(
          '/client/view-favorites',
          RequestMethod.get,
        );
        var resProvider =
            Provider.of<FavoritesProductProvider>(context, listen: false);
        FavoritesListModel favoritesListModel =
            FavoritesListModel.fromJson(response.data["data"]);
        resProvider.favoritesListModel = favoritesListModel;
        model = resProvider;
      } else {
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const LoginPage()),
          ModalRoute.withName(LoginPage.routeName),
        );
      }
    } catch (e) {
      model = null;
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
    return model;
  }
}

class ViewFavoritesDetails {
  Future<bool?> getFavoritesDetails(producId, context) async {
    bool? isLiked;
    try {
      String? token = await AccessToken.getToken();
      if (token != "Bearer null") {
        EasyLoadingIndicator.showProgres();
        NetworkProvider httpRequest =
            NetworkProvider(authToken: await AccessToken.getToken());
        Response response = await httpRequest.call(
          '/client/view-favorites-details/productId',
          RequestMethod.get,
        );
        isLiked = response.data["data"]["favorites"];
      } else {}
    } catch (e) {
      isLiked = false;
    }
    return isLiked;
  }
}

class DeleteFavoritesProduct {
  Future deleteFavorties(String? productId, context) async {
    try {
      String? token = await AccessToken.getToken();
      if (token != "Bearer null") {
        EasyLoadingIndicator.showProgres();
        NetworkProvider httpRequest =
            NetworkProvider(authToken: await AccessToken.getToken());
        Response response = await httpRequest.call(
          '/client/delete-favorites?productId=$productId',
          RequestMethod.delete,
        );
        String? message = response.data["response_message"];
        if (message != null) {
          MyFavoritesProduct favoritesProduct = MyFavoritesProduct();
          Navigator.pop(context);
          // favoritesProduct.getFavorites(context);
        }
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
  }
}
