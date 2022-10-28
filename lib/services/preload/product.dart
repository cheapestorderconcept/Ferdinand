import 'package:dio/dio.dart';
import 'package:ferdinand_coffee/provider/product_Details.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../../components/easyloading.dart';
import '../../components/fluttertoast.dart';
import '../../model/flash_sales.dart';
import '../../model/productlist.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';
import '../../model/singleproduct_details.dart';

class GetAllStoreProduct {
  Future<ProductListModel?> fetchProduct(context) async {
    ProductListModel? model;
    try {
      NetworkProvider httpRequest = NetworkProvider();
      Response response =
          await httpRequest.call('/client/view-products', RequestMethod.get);
      ProductListModel productListModel =
          ProductListModel.fromJson(response.data["data"]);
      model = productListModel;
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    }
    return model;
  }
}

class FlashSales {
  Future<FlashSalesModel?> fetchProduct(context) async {
    FlashSalesModel? model;
    try {
      NetworkProvider httpRequest = NetworkProvider();
      Response response = await httpRequest.call(
          '/client/flash-sales-products', RequestMethod.get);
      FlashSalesModel flashSalesModel =
          FlashSalesModel.fromJson(response.data["data"]);
      model = flashSalesModel;
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    }
    return model;
  }
}

class SingleProductDetails {
  Future<ProductDetailsProvider?> fetchProduct(context, productId) async {
    ProductDetailsProvider? model;
    try {
      EasyLoadingIndicator.showProgres();
      NetworkProvider httpRequest = NetworkProvider();
      Response response = await httpRequest.call(
          '/client/view-single-products/$productId', RequestMethod.get);
      var resProvider =
          Provider.of<ProductDetailsProvider>(context, listen: false);
      SingleProductDetailsModel favoritesListModel =
          SingleProductDetailsModel.fromJson(response.data);

      resProvider.setproductDetails = favoritesListModel;
      model = resProvider;
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    } finally {
      EasyLoading.dismiss();
    }
    return model;
  }
}
