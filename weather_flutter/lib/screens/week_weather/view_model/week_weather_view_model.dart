import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:weather_flutter/screens/week_weather/model/week_weather_model.dart';

class WeekWeatherViewModel extends AsyncNotifier<List<WeekWeatherModel>> {
  static final apiKey = dotenv.get("WEATHER_API_KEY");
  static const String baseUrl = "https://api.openweathermap.org/data/3.0";
  static String baseInformation = "units=metric&lang=kr&appid=$apiKey";
  List<WeekWeatherModel> _weekWeatherModelInstances = [];
  @override
  FutureOr<List<WeekWeatherModel>> build() async {
    _weekWeatherModelInstances = await fetchWeekWeatherInfo();
    return _weekWeatherModelInstances;
  }

  Future<List<WeekWeatherModel>> fetchWeekWeatherInfo() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    final lat = position.latitude;
    final lon = position.longitude;
    final url = Uri.parse(
        "$baseUrl/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly,alerts&$baseInformation");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> weekWeathers = jsonDecode(response.body);
      _weekWeatherModelInstances = [];
      for (var weekWeather in weekWeathers["daily"]) {
        final instance = WeekWeatherModel.fromJson(weekWeather);
        _weekWeatherModelInstances.add(instance);
      }
      return _weekWeatherModelInstances;
    }
    throw Error();
  }
}

final weekWeatherProvider =
    AsyncNotifierProvider<WeekWeatherViewModel, List<WeekWeatherModel>>(
  () => WeekWeatherViewModel(),
);
