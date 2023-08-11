import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/repository/open_weather_repository.dart';
import 'package:weather/domain/weather/model/city_weather.dart';
import 'package:weather/domain/weather/weather_repository.dart';
import 'package:weather/presentation/shared/resources/app_settings.dart';

part 'city_weather_event.dart';

part 'city_weather_state.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  final WeatherRepository _weatherRepository = OpenWeatherRepository();

  CityWeatherBloc() : super(CityWeatherInitial()) {
    on<CityWeatherEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
    CityWeatherEvent event,
    Emitter<CityWeatherState> emit,
  ) async {
    if (event is SearchCityWeather) {
      emit(CityWeatherLoading());
      try {
        if (event.city.isNotEmpty) {
          Response response = await _weatherRepository.getCityWeather(
            city: event.city,
            unit: 'metric',
          );
          if (response.statusCode == 200) {
            final data = CityWeather.fromJson(response.data);
            emit(CityWeatherSuccess(data));
            await _updateLastCity(event.city);
          } else {
            emit(CityWeatherFailed(response.data["message"]));
          }
        }
      } catch (error) {
        emit(const CityWeatherFailed("Not Found"));
      }
    }
  }

  Future<void> _updateLastCity(String lastCity) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppSettings.lastCity, lastCity);
  }
}
