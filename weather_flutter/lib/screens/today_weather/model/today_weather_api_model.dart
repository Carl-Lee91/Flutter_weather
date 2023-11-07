class DailyWeatherModel {
  final List<DailyWeatherDetail> weather;
  final num temp;
  final String dateTime;

  DailyWeatherModel.fromJson(Map<String, dynamic> json)
      : weather = (json["weather"] as List<dynamic>)
            .map((weatherJson) => DailyWeatherDetail.fromJson(weatherJson))
            .toList(),
        temp = json["main"]["temp"],
        dateTime = json["dt_txt"];
}

class DailyWeatherDetail {
  final String icon;

  DailyWeatherDetail.fromJson(Map<String, dynamic> json) : icon = json["icon"];
}
