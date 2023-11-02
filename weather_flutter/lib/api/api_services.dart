import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_flutter/api/model/weather_api_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<WeatherModel> fetchWeatherInfo(double lat, double lon) async {
    final apiKey = dotenv.get("WEATHER_API_KEY");
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&lang=kr&appid=$apiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final weatherInfo = jsonDecode(response.body);
      return WeatherModel.fromJson(weatherInfo);
    }
    throw Error();
  }
}
