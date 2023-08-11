import 'package:dio/dio.dart';
import 'package:weather/data/network/service/openstreetmap_location_service.dart';
import 'package:weather/domain/location/model/location_info.dart';
import 'package:weather/domain/weather/location_repository.dart';

class OpenStreetLocationRepository implements LocationRepository {
  final _openWeatherService = OpenStreetMapLocationService();

  @override
  Future<LocationInfo?> getLocationByCity({
    required String city,
    required String country,
  }) async {
    final Response response = await _openWeatherService.getPlaceInfoByCity(
        city: city, country: country);
    final List<dynamic> resultJson = response.data;
    return resultJson.map((it) => LocationInfo.fromJson(it)).firstOrNull;
  }
}
