import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/business_logic/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_forecast_app/screens/weather_animation.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  MainScreen({super.key});

  void _searchWeather(BuildContext context) {
    final bloc = context.read<WeatherBloc>();
    bloc.add(FetchWeather(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city or zip code',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _searchWeather(context),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherInitial) {
                    return Text('Enter a location to get weather information');
                  } else if (state is WeatherLoading) {
                    return SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is WeatherLoaded) {
                    final cityName = state.weather.name ?? _controller.text;
                    final currTemp = state.weather.main?.temp ?? 0;
                    final maxTemp = state.weather.main?.tempMax ?? 0;
                    final minTemp = state.weather.main?.tempMin ?? 0;
                    return LocationView(
                      weather: state.weather,
                      cityName: cityName,
                      currTemp: currTemp.toInt(),
                      maxTemp: maxTemp.toInt(),
                      minTemp: minTemp.toInt(),
                    );
                  } else if (state is WeatherError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}