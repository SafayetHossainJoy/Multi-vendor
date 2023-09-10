import 'package:dio/dio.dart';
import 'package:flutter_project_structure/main.dart';

import '../customWidgtes/dialog_helper.dart';

class DioExceptions implements Exception {
  String message;

  DioExceptions.fromDioError(DioError dioError)
      : message = _handleDioError(dioError.type);

  static String _handleDioError(DioErrorType dioErrorType) {
    switch (dioErrorType) {
      case DioErrorType.cancel:
        return "Request to API server was cancelled";
      // case DioErrorType.connectTimeout:
      //   return "Connection timeout with API server";
      case DioErrorType.sendTimeout:
        return "Send timeout in connection with API server";
      case DioErrorType.receiveTimeout:
        return "Receive timeout in connection with API server";
      // case DioErrorType.response:
      //   return _handleError(dioError.response?.statusCode ?? 400);
      // case DioErrorType.other:
      //   return "Connection to API server failed due to internet connection";
      default:
        return "Something went wrong";
    }
  }

  static String _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
      case 403:
        return "Unauthorized request";
      case 404:
        return "Not found";
      case 409:
        return "Error due to a conflict";
      case 408:
        return "Connection request timeout";
      case 500:
        return 'Internal server error';
      case 503:
        return "Service unavailable";
      default:
        return 'Oops, something went wrong';
    }
  }

  @override
  String toString() => message;
}

void retryApiFromClient(DioError e,
    {RequestOptions? reqOptions, required Dio dio, required ErrorInterceptorHandler handler}) {
  var message = DioExceptions.fromDioError(e);
  if (navigatorKey.currentContext != null) {
    DialogHelper.showExceptionDialog(
      message.toString() ?? "Something Went Wrong",
      navigatorKey.currentContext!,
      onConfirm: () {
        if (reqOptions != null) {
          dio
              .request(
            reqOptions.path,
            data: reqOptions.data,
            queryParameters: reqOptions.queryParameters,
            options: Options(
              method: reqOptions.method,
              receiveTimeout: reqOptions.receiveTimeout,
              sendTimeout: reqOptions.sendTimeout,
              extra: reqOptions.extra,
              headers: reqOptions.headers,
              responseType: reqOptions.responseType,
              contentType: reqOptions.contentType,
              validateStatus: reqOptions.validateStatus,
              receiveDataWhenStatusError: reqOptions.receiveDataWhenStatusError,
              followRedirects: reqOptions.followRedirects,
              maxRedirects: reqOptions.maxRedirects,
              requestEncoder: reqOptions.requestEncoder,
              responseDecoder: reqOptions.responseDecoder,
              listFormat: reqOptions.listFormat,
            ),
          )
              .then((value) {
            return handler.resolve(value);
          });
        }
      },
    );
  }
}
