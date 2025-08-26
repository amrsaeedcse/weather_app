part of 'weather_control_cubit.dart';

@immutable
sealed class WeatherControlState {}

final class WeatherControlInitial extends WeatherControlState {}

final class WeatherControlLoading extends WeatherControlState {}

final class WeatherControlFailure extends WeatherControlState {
  String error;
  WeatherControlFailure(this.error);
}

final class WeatherControlSuccess extends WeatherControlState {
  WeatherModel weatherModel;
  WeatherControlSuccess(this.weatherModel);
}
