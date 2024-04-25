import 'package:reality_shift/imports.dart';

final dio = Dio();
String? errorMessage;
CustomSharedPreference pref = CustomSharedPreference();

Dio axios() {
  // dio.options.baseUrl = "http://172.20.10.3:8000/api/";

  dio.options.baseUrl = "http://10.0.2.2:8000/api/"; // localhost for flutter
  dio.options.connectTimeout = const Duration(seconds: 7);
  dio.options.receiveTimeout = const Duration(seconds: 3);
  dio.options.headers['accept'] = 'Application/Json';

// Interceptors allow you to modify outgoing requests before they are sent. This can be useful for adding headers, authentication tokens,
// or other custom data to every request without having to manually include them in each request call.

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        final token = pref.getString('token') ?? '';
        options.headers['Authorization'] = 'Bearer $token';

        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        return handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        String errorMessage;
        switch (e.type) {
          case DioExceptionType.badResponse:
            errorMessage = 'Server error';
            break;
          case DioExceptionType.connectionTimeout:
            errorMessage = 'Connection Timeout';
            break;
          case DioExceptionType.receiveTimeout:
            errorMessage = 'Unable to connect to the server';
            break;
          case DioExceptionType.sendTimeout:
            errorMessage = 'Please check your internet connection';
            break;
          case DioExceptionType.unknown:
            errorMessage = 'Something went wrong';
            break;
          default:
            errorMessage = 'An error occurred';
            break;
        }

// The DioException class is used specifically for handling errors that occur during network requests made with the Dio package.
//  While interceptors like onRequest, onError, and onResponse provide hooks for intercepting and handling different stages of the request lifecycle,
// they don't directly handle errors in a structured way.

// When an error occurs during a request, such as a timeout, network failure, or server error,
//Dio encapsulates that error information into a DioException object.
//This object contains details about the error, including the request options, response (if available), error type, and message.

        DioException customError = DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            type: e.type,
            error: errorMessage,
            message: e.message);
        return handler.next(customError);
      },
    ),
  );

  return dio;
}
