// weather_api_client.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'weather_model.dart';

class WeatherApiClient {
  Future<List<Weather>> fetchWeather(String city) async {
    final response = await rootBundle.loadString('assets/weather_data.json');
    final json = jsonDecode(response);
    final weatherList = (json['consolidated_weather'] as List)
        .map((data) => Weather.fromJson(data))
        .toList();
    return weatherList;
  }
}
