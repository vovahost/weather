import 'package:weather/data/network/api_helper.dart';

class OpenWeatherService {
  static const String _baseUrl = "https://api.openweathermap.org/data/2.5";
  static const String _openWeatherApiKey = "c2244bfdf7f3262c530985717be5974e";

  final _apiHelper = ApiHelper();

  Future<dynamic> getCityWeather({
    required String city,
    required String unit,
  }) async {
    final query = "q=$city&appid=$_openWeatherApiKey&units=$unit";
    final path = "$_baseUrl/weather?$query";
    final response = await _apiHelper.get(path);
    return response;
  }

  Future<dynamic> getCityWeatherForecast({
    required double lat,
    required double long,
    required String unit,
    required String exclude,
  }) async {
    final query = "lon=$long&lat=$lat&appid=$_openWeatherApiKey&units=$unit&exclude=$exclude";
    final path = "$_baseUrl/onecall?$query";
    final response = await _apiHelper.get(path);
    return response;
  }
}
