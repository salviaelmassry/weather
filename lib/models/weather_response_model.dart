import 'package:weather/models/weather_model.dart';

class WeatherResponse {
  late final bool success;
  String? error;
  WeatherModel? result;

  WeatherResponse({
    Map<String, dynamic>? json,
  }) {
    if (json != null) {
      success = true;
      result = WeatherModel.fromJson(json);
    } else {
      success = false;
      error = 'Empty Response';
    }
  }
}
