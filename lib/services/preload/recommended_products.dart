import 'package:dio/dio.dart';
import '../../components/fluttertoast.dart';
import '../../model/product_recommendation.dart';
import '../../utils/network/api_request.dart';
import 'package:flutter/material.dart';

class RecommendedProducts {
  Future<ProductRecommendationModel?> getProductRecommendations() async {
    ProductRecommendationModel? productRecommendationModel;
    try {
      NetworkProvider httpRequest = NetworkProvider();
      Response response = await httpRequest.call(
          '/client/product-recommendation', RequestMethod.get);
      ProductRecommendationModel model =
          ProductRecommendationModel.fromJson(response.data["data"]);
      productRecommendationModel = model;
    } catch (e) {
      // displayToast(Colors.red, Colors.white, "$e");
    }
    return productRecommendationModel;
  }
}
