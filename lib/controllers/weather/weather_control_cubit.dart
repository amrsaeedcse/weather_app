import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/weather/weather_model.dart';

part 'weather_control_state.dart';

class WeatherControlCubit extends Cubit<WeatherControlState> {
  WeatherControlCubit() : super(WeatherControlInitial());
  DateTime lastUpdate = DateTime.now();

  Future getWeather(String? name) async {
    String realName;
    emit(WeatherControlLoading());

    if (name == null) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.always ||
              permission == LocationPermission.whileInUse) {
            Position position = await Geolocator.getCurrentPosition();
            print(position.toString());
            name = position.toString();
          }
        } else if (permission == LocationPermission.deniedForever) {
          print("he needs to enable manualy");
        } else if (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {
          Position position = await Geolocator.getCurrentPosition();
          print(position.toString());
          name = position.toString();
        }
      }
    } else {
      realName = name;
    }
    try {
      final response = await Dio().get(
        "http://api.weatherapi.com/v1/current.json",
        queryParameters: {"q": name, "key": "70f8406159354533aef152148252608"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = response.data as Map<String, dynamic>;
        WeatherModel weatherModel = WeatherModel.fromJson(responseBody);
        print(weatherModel.tempC);
        lastUpdate = DateTime.now();
        emit(WeatherControlSuccess(WeatherModel.fromJson(responseBody)));
      } else {
        final responseBody = response.data as Map<String, dynamic>;
        emit(WeatherControlFailure(responseBody["message"]));
      }
    } catch (e) {
      emit(WeatherControlFailure("error"));
    }
  }
}
