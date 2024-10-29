// weather_state.dart
import 'weather_model.dart';

enum TemperatureUnit { celsius, fahrenheit }

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<Weather> weatherList;
  final TemperatureUnit unit;

  WeatherLoaded(this.weatherList, {this.unit = TemperatureUnit.celsius});
}

class WeatherError extends WeatherState {}
