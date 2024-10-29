// weather_bloc.dart
import 'package:bloc/bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import 'weather_api_client.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherApiClient weatherApiClient;

  WeatherBloc({required this.weatherApiClient}) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weatherList = await weatherApiClient.fetchWeather(event.city);
        emit(WeatherLoaded(weatherList));
      } catch (_) {
        emit(WeatherError());
      }
    });

    on<ToggleTemperatureUnit>((event, emit) {
      if (state is WeatherLoaded) {
        final currentState = state as WeatherLoaded;
        final newUnit = currentState.unit == TemperatureUnit.celsius
            ? TemperatureUnit.fahrenheit
            : TemperatureUnit.celsius;
        emit(WeatherLoaded(currentState.weatherList, unit: newUnit));
      }
    });
  }
}
