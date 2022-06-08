import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/models/weather_response_model.dart';
import 'package:weather/repository/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherInitialState()) {
    on<GetCurrentWeatherEvent>(
        (GetCurrentWeatherEvent event, Emitter<WeatherState> emit) async {
      try {
        emit(const WeatherLoadingState());
        WeatherResponse response =
            await WeatherRepo.getWeatherInfo(location: event.location);
        if (response.success) {
          emit(WeatherSuccessState(weatherModel: response.result!));
        } else {
          emit(WeatherFailedState(error: response.error!));
        }
      } on DioError catch (e) {
        if (e.message.contains('SocketException')) {
          emit(ConnectionError());
        } else {
          emit(WeatherFailedState(error: e.message));
        }
      } catch (e) {
        if (e is SocketException) {
          emit(ConnectionError());
        } else {
          emit(WeatherFailedState(error: e.toString()));
        }
      }
    });
  }
}