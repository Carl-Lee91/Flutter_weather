import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_flutter/screens/today_weather/model/today_weather_api_model.dart';

import 'package:http/http.dart' as http;

class DailyWeatherViewModel extends AsyncNotifier<List<DailyWeatherModel>> {
  static final apiKey = dotenv.get("WEATHER_API_KEY");
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";
  static String baseInformation = "units=metric&lang=kr&appid=$apiKey";
  List<DailyWeatherModel> _dailyWeatherModelInstances = [];
  @override
  FutureOr<List<DailyWeatherModel>> build() async {
    _dailyWeatherModelInstances = await fetchDailyWeatherInfo();
    return _dailyWeatherModelInstances;
  }

  Future<List<DailyWeatherModel>> fetchDailyWeatherInfo() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    final lat = position.latitude;
    final lon = position.longitude;
    final url =
        Uri.parse("$baseUrl/forecast?lat=$lat&lon=$lon&cnt=9&$baseInformation");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> dailyWeathers = jsonDecode(response.body);
      _dailyWeatherModelInstances = [];
      for (var dailyWeather in dailyWeathers["list"]) {
        final instance = DailyWeatherModel.fromJson(dailyWeather);
        _dailyWeatherModelInstances.add(instance);
      }
      return _dailyWeatherModelInstances;
    }
    throw Error();
  }
}

final dailyWeatherProvider =
    AsyncNotifierProvider<DailyWeatherViewModel, List<DailyWeatherModel>>(
  () => DailyWeatherViewModel(),
);
