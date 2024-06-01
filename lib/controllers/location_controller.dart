import 'package:dio/dio.dart' as Dio;
import 'package:reality_shift/imports.dart';

class LocationController {
  Future<Map> createContinent(FormData cred) async {
    // print(cred);
    try {
      Dio.Response response =
          await axios().post("location/create_continents", data: cred);
      return response.data;
    } on Dio.DioException catch (e) {
      print(e);
      return {"status": "error", "message": e.error};
    }
  }

  Future<Map> fetchAllContinents() async {
    try {
      Dio.Response response = await axios().get("location/fetch_continents");

      // Logging response for debugging
      // print('Response status: ${response.statusCode}');
      // print('Response headers: ${response.headers}');
      // print('Response data: ${response.data}');

      return response.data;
    } on Dio.DioException catch (e) {
      if (e.response != null) {
        // The server responded with an error code
        print('Error response: ${e.response?.data}');
        return {"status": "error", "message": e.response?.data};
      } else {
        // The request did not reach the server
        print('Error sending request: $e');
        return {"status": "error", "message": e.message};
      }
      // print(e);
      // return {"status": "error", "message": e.error};
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
