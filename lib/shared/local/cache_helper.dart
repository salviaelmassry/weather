import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/weather_model.dart';

class CacheHelper {

  static Future<void> storeWeatherInfo(Map<String, dynamic>? json,) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String weatherInfo = jsonEncode(json);
    await prefs.setString("weatherInfo", weatherInfo);
  }

  static Future<WeatherModel> getStoredWeatherInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> weatherInfo = jsonDecode(prefs.getString('weatherInfo')!);
    //convert it into User object
    return WeatherModel.fromJson(weatherInfo);
  }

}
