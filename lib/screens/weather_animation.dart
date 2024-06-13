import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forecast_app/business_logic/models/weather_model.dart';

class LocationView extends StatelessWidget {
  final String cityName;
  final int currTemp;
  final int maxTemp;
  final int minTemp;
  final WeatherModel weather;

  const LocationView({
    super.key,
    required this.weather,
    required this.cityName,
    required this.currTemp,
    required this.maxTemp,
    required this.minTemp,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = false;
    return Container(
      height: size.height,
      width: size.height,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(),
              child: Align(
                child: Text(
                  cityName,
                  style: GoogleFonts.questrial(
                    fontSize: size.height * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.03,
              ),
              child: Align(
                child: Text(
                  '$currTemp˚C', //curent temperature
                  style: GoogleFonts.questrial(
                    color: currTemp <= 0
                        ? Colors.blue
                        : currTemp > 0 && currTemp <= 15
                            ? Colors.indigo
                            : currTemp > 15 && currTemp < 30
                                ? Colors.deepPurple
                                : Colors.green,
                    fontSize: size.height * 0.13,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
              child: Divider(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            if(weather.weather?.isNotEmpty==true)
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.005,
              ),
              child: Align(
                child: Text(
                  weather.weather?.first.main??'Sunny', // weather
                  style: GoogleFonts.questrial(
                    color: isDarkMode ? Colors.white54 : Colors.deepPurple,
                    fontSize: size.height * 0.03,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.03,
                bottom: size.height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$minTemp˚C', // min temperature
                    style: GoogleFonts.questrial(
                      color: minTemp <= 0
                          ? Colors.blue
                          : minTemp > 0 && minTemp <= 15
                              ? Colors.indigo
                              : minTemp > 15 && minTemp < 30
                                  ? Colors.deepPurple
                                  : Colors.green,
                      fontSize: size.height * 0.03,
                    ),
                  ),
                  Text(
                    '-',
                    style: GoogleFonts.questrial(
                      color: isDarkMode ? Colors.white54 : Colors.black54,
                      fontSize: size.height * 0.03,
                    ),
                  ),
                  Text(
                    '$maxTemp˚C', //max temperature
                    style: GoogleFonts.questrial(
                      color: maxTemp <= 0
                          ? Colors.blue
                          : maxTemp > 0 && maxTemp <= 15
                              ? Colors.indigo
                              : maxTemp > 15 && maxTemp < 30
                                  ? Colors.deepPurple
                                  : Colors.green,
                      fontSize: size.height * 0.03,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.03,
                bottom: size.height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Humidity: ${weather.main?.humidity??0}%',
                    style: TextStyle(fontSize: 20,color: Colors.deepPurple),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.03,
                bottom: size.height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wind Speed: ${weather.wind?.speed??0} m/s',
                    style: TextStyle(fontSize: 20,color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}