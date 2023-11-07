import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_flutter/screens/today_weather/model/today_air_pollution_api_model.dart';
import 'package:http/http.dart' as http;

class AirPollutionViewModel extends AsyncNotifier<void> {
  static final apiKey = dotenv.get("WEATHER_API_KEY");
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";
  static String baseInformation = "units=metric&lang=kr&appid=$apiKey";

  @override
  FutureOr<void> build() {}
  Future<AirPollutionModel> fetchAirPollutionInfo() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    final lat = position.latitude;
    final lon = position.longitude;
    final url =
        Uri.parse("$baseUrl/air_pollution?lat=$lat&lon=$lon&$baseInformation");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final airPollutionInfo = jsonDecode(response.body);
      return AirPollutionModel.fromJson(airPollutionInfo);
    }
    throw Error();
  }
}

final airPollutionProvider = AsyncNotifierProvider<AirPollutionViewModel, void>(
  () => AirPollutionViewModel(),
);
