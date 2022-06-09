import 'package:weather/models/weather_model.dart';
import 'package:weather/shared/local/cache_helper.dart';

class WeatherResponse {
  late final bool success;
  String? error;
  WeatherModel? result;

  WeatherResponse({
    Map<String, dynamic>? json,
  }) {
    if (json != null) {
      CacheHelper.storeWeatherInfo(json);
      success = true;
      result = WeatherModel.fromJson(json);
    } else {
      success = false;
      error = 'Empty Response';
    }
  }
}
