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
}
