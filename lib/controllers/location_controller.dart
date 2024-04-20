import 'package:dio/dio.dart' as Dio;
import 'package:reality_shift/services/dio.dart';

class LocationController {
  Future<Map> allContinents() async {
    try {
      Dio.Response response = await axios().get(
        "location/continents",
      );
      return response.data;
    } on Dio.DioException catch (e) {
      print(e);
      return {"status": "error", "message": e.error};
    }
  }
  Future<Map> continentDetails(id) async {
    try {
      Dio.Response response = await axios().get(
        "location/continents/$id",
      );
      return response.data;
    } on Dio.DioException catch (e) {
      print(e);
      return {"status": "error", "message": e.error};
    }
  }
}
