import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_forecast_app/business_logic/models/weather_model.dart';
import 'package:weather_forecast_app/business_logic/services/response_wrapper.dart';

class WeatherService {
  final String apiKey = 'e241a7a1b02013d6bfef3b9a40e99e92';

  // Private constructor
  WeatherService._internal();

  // The singleton instance
  static final WeatherService _instance = WeatherService._internal();

  // Getter for the singleton instance
  static WeatherService get instance => _instance;

  Future<ResponseWrapper<WeatherModel>> fetchWeather(String location) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric'));
      print("statusCode=> ${response.statusCode}");
      print("response=> ${response.body}");
      if (response.statusCode == 200) {
        final weather = weatherModelFromJson(response.body);
        return ResponseWrapper(data: weather);
      } else if (response.statusCode == 404) {
        return ResponseWrapper(error: 'City not found');
      } else {
        return ResponseWrapper(error: 'Failed to load weather data');
      }
    } catch (e, s) {
      print(s);
      return ResponseWrapper(error: 'An error occurred: $e');
    }
  }
}
