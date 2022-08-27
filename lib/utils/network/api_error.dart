import 'package:dio/dio.dart';

class ApiError {
  int? statusCode;
  int? errorStatusCode = 0;
  String errorDescription = '';

  ApiError({this.errorDescription = '', this.statusCode});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  void _handleError(Object error) {
//Todo change the error message accordingly
    if (error is DioError) {
      DioError dioError = error; // as DioError;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request cancelled. please try again later";
          break;
        case DioErrorType.connectTimeout:
          errorDescription =
              "Connection timeout. Seems you have low internet connection";
          break;
        case DioErrorType.other:
          errorDescription = "Please check your internet connection.";
          break;
        // case DioErrorType.receiveTimeout:
        //   errorDescription = "Request Timeout. Check your internet connection";
        //   break;
        case DioErrorType.receiveTimeout:
          statusCode = dioError.response?.statusCode;
          //Todo extract your response error
          errorDescription = "Network timeout";
          errorStatusCode = 400;
          switch (statusCode) {
            case 401:
              errorDescription =
                  extractDescriptionFromResponse(dioError.response);
              errorStatusCode = extraStatusCode(dioError
                  .response); // the error description are okay. Want a dynamic response base on status code
              break;
            case 422:
              errorDescription =
                  extractDescriptionFromResponse(dioError.response);
              break;
            case 404:
              errorDescription =
                  extractDescriptionFromResponse(dioError.response);
              statusCode = extraStatusCode(dioError.response);
              break;
            case 402:
              errorDescription =
                  extractDescriptionFromResponse(dioError.response);
              break;
            case 409:
              errorDescription =
                  extractDescriptionFromResponse(dioError.response);
              break;
            case 500:
              errorDescription =
                  "Something went wrong. We are working to fix this as soon as possible. Contact support if persists";
              break;
            default:
              errorDescription = "Unknown error occured";
          }
          // this.errorDescription =
          //     extractDescriptionFromResponse(dioError.response);
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Time out";
          break;
        default:
          //errorDescription = "Something went wrong";
          errorDescription = extractDescriptionFromResponse(dioError.response);
      }
    } else {
      errorDescription = "Unknown error occur, try again";
    }
  }

  int? extraStatusCode(Response? response) {
    int? statusCodes = 0;
    try {
      if (response?.data != null && response?.data["status_code"] != null) {
        statusCodes = response?.data["status_code"];
      } else {
        statusCodes = response?.statusCode;
      }
    } catch (e) {
      statusCodes = response?.statusCode;
    }

    return statusCodes;
  }

  extractDescriptionFromResponse(Response? response) {
    String? message = "";
    try {
      if (response?.data != null &&
          response?.data["response_message"] != null) {
        message = response?.data["response_message"];
      } else {
        message = response?.statusMessage;
      }
    } catch (error) {
      message = response?.statusMessage ?? error.toString();
    }
    return message;
  }

  @override
  String toString() => errorDescription;
}
