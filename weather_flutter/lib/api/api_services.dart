import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_flutter/screens/today_weather/model/daily_weather_api_model.dart';

class ApiServices {
  static final apiKey = dotenv.get("WEATHER_API_KEY");
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";
  static String baseInformation = "units=metric&lang=kr&appid=$apiKey";

  static Future<List<DailyWeatherModel>> fetchDailyWeatherInfo(
      double lat, double lon) async {
    List<DailyWeatherModel> dailyWeatherModelInstances = [];
    final url =
        Uri.parse("$baseUrl/forecast?lat=$lat&lon=$lon&cnt=9&$baseInformation");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> dailyWeathers = jsonDecode(response.body);
      for (var dailyWeather in dailyWeathers["list"]) {
        final instance = DailyWeatherModel.fromJson(dailyWeather);
        dailyWeatherModelInstances.add(instance);
      }
      return dailyWeatherModelInstances;
    }
    throw Error();
  }
}
