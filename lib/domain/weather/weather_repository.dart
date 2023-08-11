abstract class WeatherRepository {
  Future<dynamic> getCityWeather({
    required String city,
    required String unit,
  });
}
