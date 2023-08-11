part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final WeatherData weatherData;
  final String place;

  const HomeSuccess(this.weatherData, this.place);

  @override
  List<Object> get props => [weatherData, place];
}

class HomeFailed extends HomeState {
  final String error;

  const HomeFailed(this.error);

  @override
  List<Object> get props => [error];
}

extension WeatherDataExtension on WeatherData {
  String get currentWeatherBgImage {
    final weatherIcon = current.weather.first.icon;
    if (weatherIcon.endsWith('n')) {
      return 'assets/images/night_mode.gif';
    } else {
      return 'assets/images/sun_mode.gif';
    }
  }
}
