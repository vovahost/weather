import 'package:dio/dio.dart';
import 'package:weather/data/network/api_helper.dart';

class OpenStreetMapLocationService {
  static const String _baseUrl = "https://nominatim.openstreetmap.org";

  final _apiHelper = ApiHelper();

  Future<Response> getPlaceInfoByCity({
    required String city,
    required String country,
  }) async {
    final query = "q=$city,$country&format=json";
    final path = "$_baseUrl/search?$query";
    final response = await _apiHelper.get(path);
    return response;
  }
}
