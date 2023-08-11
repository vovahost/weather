import 'package:weather/data/network/service/open_weather_service.dart';
import 'package:weather/domain/weather/weather_repository.dart';

class OpenWeatherRepository implements WeatherRepository {
  final _openWeatherService = OpenWeatherService();

  @override
  Future<dynamic> getCityWeather({
    required String city,
    String unit = 'metric',
  }) async {
    return await _openWeatherService.getCityWeather(
      city: city,
      unit: unit,
    );
  }

  @override
  Future<dynamic> getCityForecast({
    required double lat,
    required double long,
    required String unit,
    required String exclude,
  }) async {
    return await _openWeatherService.getCityWeatherForecast(
      lat: lat,
      long: long,
      unit: unit,
      exclude: exclude,
    );
  }
}
