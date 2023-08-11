part of '../bloc/city_weather_bloc.dart';

abstract class CityWeatherState extends Equatable {
  const CityWeatherState();
}

class CityWeatherInitial extends CityWeatherState {
  @override
  List<Object> get props => [];
}

class CityWeatherLoading extends CityWeatherState {
  @override
  List<Object> get props => [];
}

class CityWeatherSuccess extends CityWeatherState {
  final CityWeather weather;

  const CityWeatherSuccess(this.weather);

  @override
  List<Object> get props => [weather];
}

extension WeatherExtension on CityWeather {
  String get currentWeatherBgImage {
    final weatherIcon = weather.first.icon;
    if(weatherIcon.endsWith('n')){
      return 'assets/images/night_mode.gif';
    } else {
      return 'assets/images/sun_mode.gif';
    }
  }
}

class CityWeatherFailed extends CityWeatherState {
  final String error;

  const CityWeatherFailed(this.error);

  @override
  List<Object> get props => [error];
}
