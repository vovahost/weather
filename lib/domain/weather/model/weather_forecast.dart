import 'package:equatable/equatable.dart';
import 'package:weather/domain/weather/model/current_weather.dart';
import 'package:weather/domain/weather/model/daily_model.dart';

class WeatherData extends Equatable {
  const WeatherData({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    this.hourly = const [],
    this.daily = const [],
  });

  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather current;
  final List<CurrentWeather> hourly;
  final List<DailyWeather> daily;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: CurrentWeather.fromJson(json["current"]),
        hourly: List<CurrentWeather>.from(
            json["hourly"].map((x) => CurrentWeather.fromJson(x))),
        daily: List<DailyWeather>.from(
            json["daily"].map((x) => DailyWeather.fromJson(x))),
      );

  @override
  List<Object> get props => [
        lat,
        lon,
        timezone,
        timezoneOffset,
        current,
        hourly,
        daily,
      ];
}

class WeatherDataNew extends Equatable {
  const WeatherDataNew({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    this.hourly = const [],
    this.daily = const [],
  });

  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather current;
  final List<CurrentWeather> hourly;
  final List<DailyWeather> daily;

  factory WeatherDataNew.fromJson(Map<String, dynamic> json) => WeatherDataNew(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: CurrentWeather.fromJson(json["current"]),
        hourly: List<CurrentWeather>.from(
            json["hourly"].map((x) => CurrentWeather.fromJson(x))),
      );

  @override
  List<Object> get props => [
        lat,
        lon,
        timezone,
        timezoneOffset,
        current,
        hourly,
        daily,
      ];
}
