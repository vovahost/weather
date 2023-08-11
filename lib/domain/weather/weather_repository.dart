abstract class WeatherRepository {
  Future<dynamic> getCityWeather({
    required String city,
    required String unit,
  });

  Future<dynamic> getCityForecast({
    required double lat,
    required double long,
    required String unit,
    required String exclude,
  });
}
