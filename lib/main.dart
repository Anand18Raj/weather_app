// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import 'weather_api_client.dart';
import 'weather_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: BlocProvider(
        create: (context) => WeatherBloc(
          weatherApiClient: WeatherApiClient(),
        ),
        child: WeatherPage(),
      ),
    );
  }
}

class WeatherPage extends StatelessWidget {
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final city = cityController.text;
                context.read<WeatherBloc>().add(FetchWeather(city));
              },
              child: Text('Fetch Weather'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<WeatherBloc>().add(ToggleTemperatureUnit());
              },
              child: Text('Toggle Temperature Unit'),
            ),
            SizedBox(height: 20),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.weatherList.length,
                      itemBuilder: (context, index) {
                        final weather = state.weatherList[index];
                        final temperature = state.unit == TemperatureUnit.celsius
                            ? weather.theTemp
                            : weather.theTemp * 9 / 5 + 32;
                        final unitSymbol = state.unit == TemperatureUnit.celsius
                            ? '°C'
                            : '°F';
                        final color = temperature > 25 ? Colors.red : Colors.blue;
                        return ListTile(
                          title: Text('${weather.weatherStateName}'),
                          subtitle: Text(
                              'Temperature: ${temperature.toStringAsFixed(1)}$unitSymbol'),
                          tileColor: color.withOpacity(0.2),
                        );
                      },
                    ),
                  );
                } else if (state is WeatherError) {
                  return Text(
                    'Failed to fetch weather',
                    style: TextStyle(fontSize: 24.0, color: Colors.red),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
