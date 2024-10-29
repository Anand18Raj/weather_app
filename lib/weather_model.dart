// weather_model.dart
class Weather {
  final String weatherStateName;
  final double minTemp;
  final double maxTemp;
  final double theTemp;

  Weather({
    required this.weatherStateName,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weatherStateName: json['weather_state_name'],
      minTemp: json['min_temp'],
      maxTemp: json['max_temp'],
      theTemp: json['the_temp'],
    );
  }
}
