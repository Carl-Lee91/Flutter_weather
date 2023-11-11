class WeekWeatherModel {
  final List<WeekWeatherDetail> weather;
  final num? temp, minTemp, maxTemp;

  WeekWeatherModel.fromJson(Map<String, dynamic> json)
      : weather = (json["weather"] as List<dynamic>)
            .map((weatherJson) => WeekWeatherDetail.fromJson(weatherJson))
            .toList(),
        temp = json["temp"]["day"],
        minTemp = json["temp"]["min"],
        maxTemp = json["temp"]["max"];
}

class WeekWeatherDetail {
  final String icon;

  WeekWeatherDetail.fromJson(Map<String, dynamic> json) : icon = json["icon"];
}
