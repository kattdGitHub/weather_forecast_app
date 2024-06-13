import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/business_logic/models/weather_model.dart';
import 'package:weather_forecast_app/business_logic/services/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc() : weatherService = WeatherService.instance, super(WeatherInitial()){
    on<FetchWeather>(_onFetchWeather);
  }

  Future<FutureOr<void>> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit,) async {
    try {
      emit(WeatherLoading());
      final response = await weatherService.fetchWeather(event.city);
      if(response.isSuccess&&response.data!=null) {
        emit(WeatherLoaded(response.data!));
      }else{
        emit(WeatherError(response.error??"Something went wrong"));
      }
    } catch (e, s) {
      _blocLog(s,e);
      emit(WeatherError(e.toString()));
    }
  }

  void _blocLog(StackTrace s, Object e) {
    if (kDebugMode) {
      print("WeatherBloc()=>$e$s");
    }
  }
}
