import 'package:dio/dio.dart' as Dio;
import 'package:reality_shift/imports.dart';
import 'package:reality_shift/services/dio.dart';

class UserController {
  Future<Map> profile(FormData cred) async {
    print("credentials : $cred");
    try {
      Dio.Response response = await axios().post("user/profile", data: cred);
      return response.data;
    } on Dio.DioException catch (e) {
      print(e);
      return {"status": "error", "message": e.error};
    }
  }
}
