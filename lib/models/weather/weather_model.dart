class WeatherModel {
  final String country;
  final String name;
  final double tempC;
  final String conditionText;
  final String conditionIcon;
  final double humidity;
  final double windKph;
  final double feelsLikeC;
  final double pressureMb;
  final int isDay;
  WeatherModel({
    required this.isDay,
    required this.name,
    required this.conditionIcon,
    required this.conditionText,
    required this.country,
    required this.feelsLikeC,
    required this.humidity,
    required this.pressureMb,
    required this.tempC,
    required this.windKph,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      isDay: json["current"]["is_day"],
      name: json["location"]["name"],
      conditionIcon: json["current"]["condition"]['icon'],
      conditionText: json["current"]["condition"]['text'],
      country: json["location"]["country"],
      feelsLikeC: json["current"]["feelslike_c"],
      humidity: (json["current"]["humidity"] as num).toDouble(),
      pressureMb: json["current"]["pressure_mb"],
      tempC: json["current"]["temp_c"],
      windKph: json["current"]["wind_kph"],
    );
  }
}
