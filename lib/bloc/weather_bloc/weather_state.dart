part of 'weather_bloc.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitialState extends WeatherState {
  const WeatherInitialState();

  List<Object?> get props => <Object>[];
}

class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();

  List<Object?> get props => <Object>[];
}

class WeatherSuccessState extends WeatherState {
  final WeatherModel weatherModel;
  const WeatherSuccessState({required this.weatherModel});

  List<Object?> get props => <Object>[weatherModel];
}

class WeatherFailedState extends WeatherState {
  final String error;
  WeatherFailedState({required this.error});
}

class ConnectionError extends WeatherState {}
