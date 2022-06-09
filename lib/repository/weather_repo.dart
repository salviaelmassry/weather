import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:weather/api/api_service.dart';
import 'package:weather/api/apis_paths.dart';
import 'package:weather/api/app_config.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/models/weather_response_model.dart';
import 'package:weather/shared/local/cache_helper.dart';

class WeatherRepo {
  static Future<WeatherResponse> getWeatherInfo(
      {required Coord location}) async {
    final Response<dynamic>? response = await ApiService.getApi(ApiPaths
            .getCurrentWeather +
        '?lat=${location.lat}&lon=${location.lon}&units=metric&appid=${AppConfig.currentWeatherApiKey}');
    return WeatherResponse(
      json: response?.data,
    );
  }

  static Future<Coord> getCurrentLocation() async {
    final Location? location;

    location = Location();

    try {
      final LocationData _locationResult = await location.getLocation();
      return Coord(lat: _locationResult.latitude, lon: _locationResult.longitude);
    } catch (e) {
      print(e);
    }
    return Coord(lat: 1.2, lon: 1.56);
  }
}
