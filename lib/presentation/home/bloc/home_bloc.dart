import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/repository/open_weather_repository.dart';
import 'package:weather/data/repository/openstreetmap_location_repository.dart';
import 'package:weather/domain/location/model/location_info.dart';
import 'package:weather/domain/weather/location_repository.dart';
import 'package:weather/domain/weather/model/weather_forecast.dart';
import 'package:weather/domain/weather/weather_repository.dart';
import 'package:weather/presentation/shared/resources/app_settings.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository _repository = OpenWeatherRepository();
  final LocationRepository _locationRepository = OpenStreetLocationRepository();

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>(_mapEventToState);
    add(GetLastCityForecast());
  }

  Future<void> _mapEventToState(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (event is GetLastCityForecast) {
      await _handleGetLastCityEvent(event: event, emit: emit);
    }
  }

  Future<void> _handleGetLastCityEvent({
    required GetLastCityForecast event,
    required Emitter<HomeState> emit,
  }) async {
    emit(HomeLoading());
    try {
      final city = await _getLastCity();
      final LocationInfo? location =
          await _locationRepository.getLocationByCity(
        city: city,
        country: 'uk',
      );
      if (location == null) {
        emit(HomeFailed('Can\'t retrieve $city location'));
        return;
      }
      Response response = await _repository.getCityForecast(
        lat: double.parse(location.lat!),
        long: double.parse(location.lon!),
        unit: 'metric',
        exclude: '',
      );

      if (response.statusCode == 200) {
        final weatherData = WeatherData.fromJson(response.data);
        emit(HomeSuccess(weatherData, city));
      } else {
        emit(HomeFailed(response.data['message']));
      }
    } catch (e) {
      emit(HomeFailed(e.toString()));
    }
  }

  Future<String> _getLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppSettings.lastCity) ?? 'London';
  }
}
