import 'package:dio/dio.dart' as Dio;
import 'package:reality_shift/services/dio.dart';

class AuthController {
// In the provided code snippet, import 'package:dio/dio.dart' as Dio; is importing the dio package and giving it an alias Dio.
// This means that when you use classes or functions from the dio package in your code, you have to prefix them with Dio.
// to indicate that they belong to the Dio namespace.

// For example, instead of writing Response directly, you would use Dio.Response. This helps to prevent naming conflicts
//if you have other classes or functions with the same name in your code.

  Future<Map> register(Map cred) async {
    print("credentials : $cred");
    try {
      // Dio.Response response = await axios().get("/", data: cred);
      Dio.Response response = await axios().post("auth/register", data: cred);
      // print(response);
      return response.data;
    } on Dio.DioException catch (e) {
      print(e);
      return {"status": "error", "message": e.error};
    }
  }

  Future<Map> login(Map cred) async {
    print("credentials : $cred");
    try {
      Dio.Response response = await axios().post("auth/login", data: cred);
      return response.data;
    } on Dio.DioException catch (e) {
      print(e);
      return {"status": "error", "message": e.error};
    }
  }

  Future<Map> checkOtp(Map cred) async {
    print("credentials : $cred");
    try {
      Dio.Response response = await axios().post("auth/checkotp", data: cred);
      print(response);
      return response.data;
    } on Dio.DioException catch (e) {
      return {"status": "error", "message": e.error};
    }
  }

  Future<Map> sendOtp(Map cred) async {
    print("credentials : $cred");
    try {
      Dio.Response response = await axios().post("auth/sendotp", data: cred);
      print(response);
      return response.data;
    } on Dio.DioException catch (e) {
      return {"status": "error", "message": e.error};
    }
  }

  Future<Map> checkAccount(Map cred) async {
    print("credentials : $cred");
    try {
      Dio.Response response = await axios().post("auth/checkEmail", data: cred);
      // print(response);
      return response.data;
    } on Dio.DioException catch (e) {
      print(e);
      return {"status": "error", "message": e.error};
    }
  }

  Future<Map> resetPassword(Map cred) async {
    print("credentials : $cred");
    try {
      Dio.Response response = await axios().post("auth/resetPassword", data: cred);
      // print(response);
      return response.data;
    } on Dio.DioException catch (e) {
      print(e);
      return {"status": "error", "message": e.error};
    }
  }


}
