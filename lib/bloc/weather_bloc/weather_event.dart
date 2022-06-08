part of 'weather_bloc.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class GetCurrentWeatherEvent extends WeatherEvent {
  final Coord location;
  const GetCurrentWeatherEvent({required this.location});
}
