import 'package:reality_shift/imports.dart';

final dio = Dio();
String? errorMsg;
CustomSharedPreference pref = CustomSharedPreference();

Dio axios() {
  dio.options.baseUrl = "http://10.0.2.2:8000/api/";
  dio.options.connectTimeout = Duration(seconds: 7);
  dio.options.receiveTimeout = Duration(seconds: 3);
  //data form to accept
  dio.options.headers["accept"] = "Application/Json";

// Interceptors allow you to modify outgoing requests before they are sent. This can be useful for adding headers, authentication tokens,
// or other custom data to every request without having to manually include them in each request call.

  dio.interceptors.add(InterceptorsWrapper(
    onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      final token = pref.getString("token") ?? "";
      options.headers["Authorization"] = "Bearer $token";
    },
    onResponse: (Response response, ResponseInterceptorHandler handler) {
      return handler.next(response);
    },
    onError: (DioException err, ErrorInterceptorHandler handler) {
      // errorMsg;

      switch (err.type) {
        case DioExceptionType.badResponse:
          errorMsg = "Server error";
          break;
        case DioExceptionType.connectionTimeout:
          errorMsg = 'Connection Timeout';
          break;
        case DioExceptionType.receiveTimeout:
          errorMsg = 'Unable to connect to the server';
          break;
        case DioExceptionType.sendTimeout:
          errorMsg = 'Please check your internet connection';
          break;
        case DioExceptionType.unknown:
          errorMsg = 'Something went wrong';
          break;
        default:
          errorMsg = 'An error occurred';
          break;
      }

// The DioException class is used specifically for handling errors that occur during network requests made with the Dio package.
//  While interceptors like onRequest, onError, and onResponse provide hooks for intercepting and handling different stages of the request lifecycle,
// they don't directly handle errors in a structured way.

// When an error occurs during a request, such as a timeout, network failure, or server error,
//Dio encapsulates that error information into a DioException object.
//This object contains details about the error, including the request options, response (if available), error type, and message.

      DioException customError = DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: errorMsg,
        message: err.message,
      );
      return handler.next(customError);
    },
  ));

  return dio;
}
