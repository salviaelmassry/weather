class WeatherModel {
  final Main? main;
  final Coord? coord;

  const WeatherModel({this.main, this.coord});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      main: json['main'] != null
          ? Main.fromJson(json['main'] as Map<String, dynamic>)
          : null,
      coord: json['coord'] != null
          ? Coord.fromJson(json['coord'] as Map<String, dynamic>)
          : null,
    );
  }
}

////////---------------------MAIN OBJECT IN WEATHER API RESPONSE-----------------///////

class Main {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final DateTime? date;

  const Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.date,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
        temp: json['temp'],
        feelsLike: json['feels_like'],
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        date: DateTime.now());
  }
}

////////---------------------MAIN OBJECT IN WEATHER API RESPONSE-----------------///////

class Coord {
  final double? lat;
  final double? lon;

  const Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(lat: json['lat'], lon: json['lon']);
  }
}
