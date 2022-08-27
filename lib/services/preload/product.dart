import 'package:dio/dio.dart';
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
  Future<SingleProductDetailsModel?> fetchProduct(context, productId) async {
    SingleProductDetailsModel? model;
    try {
      NetworkProvider httpRequest = NetworkProvider();
      Response response = await httpRequest.call(
          '/client/view-single-products/$productId', RequestMethod.get);
      SingleProductDetailsModel flashSalesModel =
          SingleProductDetailsModel.fromJson(response.data["data"]);
      model = flashSalesModel;
    } catch (e) {
      displayToast(Colors.red, Colors.white, '$e');
    }
    return model;
  }
}
