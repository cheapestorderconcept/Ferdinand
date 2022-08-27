import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_error.dart';

/// To use this class just call
/// final networkProvider = NetworkProvider();
// networkProvider.call(path, method);
/// This class should be injected to all your services class that need to make network calls
class NetworkProvider {
  static const int CONNECT_TIME_OUT = 30000;
  static const int RECEIVE_TIME_OUT = 30000;
  static const int SEND_TIME_OUT = 30000;
  Dio dio = Dio();
  final storage = const FlutterSecureStorage();
  NetworkProvider({String baseUrl = Constants.baseUrl, String? authToken}) {
    dio = Dio(BaseOptions(
        headers: {HttpHeaders.authorizationHeader: authToken},
        connectTimeout: CONNECT_TIME_OUT,
        receiveTimeout: RECEIVE_TIME_OUT,
        sendTimeout: SEND_TIME_OUT,
        baseUrl: baseUrl));
  }

  NetworkProvider.test(this.dio);

  Future<Response> call(
    String path,
    RequestMethod method, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    Response response;
    var params = queryParams ?? {};
    params.addAll(requiredParams);
    try {
      switch (method) {
        case RequestMethod.post:
          response = await dio.post(path,
              queryParameters: params, data: data ?? formData);
          break;
        case RequestMethod.get:
          response = await dio.get(path, queryParameters: params);
          break;
        case RequestMethod.put:
          response = await dio.put(path, queryParameters: params, data: data);
          break;
        case RequestMethod.delete:
          response =
              await dio.delete(path, queryParameters: params, data: data);
          break;
        case RequestMethod.upload:
          throw UnimplementedError();
      }
      return response;
    } on DioError catch (error, stackTrace) {
      var apiError = ApiError.fromDio(error);
      return Future.error(apiError, stackTrace);
    }
  }

  Map<String, dynamic> get requiredParams {
    //Todo add all required params for your endpoint here if any
    Map<String, dynamic> params = {};
    return params;
  }
}

enum RequestMethod { post, get, put, delete, upload }
