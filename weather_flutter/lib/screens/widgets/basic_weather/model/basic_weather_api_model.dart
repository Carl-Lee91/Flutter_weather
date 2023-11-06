class BasicWeatherModel {
  final List<BasicWeatherDetail> weather;
  final double temp, feelTemp, minTemp, maxTemp;
  final int id, pressure, humidity, windDeg;
  final dynamic windSpeed;
  final String cityName;

  BasicWeatherModel.fromJson(Map<String, dynamic> json)
      : weather = (json["weather"] as List<dynamic>)
            .map((weatherJson) => BasicWeatherDetail.fromJson(weatherJson))
            .toList(),
        temp = json["main"]["temp"],
        feelTemp = json["main"]["feels_like"],
        minTemp = json["main"]["temp_min"],
        maxTemp = json["main"]["temp_max"],
        pressure = json["main"]["pressure"],
        humidity = json["main"]["humidity"],
        windSpeed = json["wind"]["speed"],
        windDeg = json["wind"]["deg"],
        id = json["id"],
        cityName = json["name"];
}

class BasicWeatherDetail {
  final int weatherId;
  final String description, icon;

  BasicWeatherDetail.fromJson(Map<String, dynamic> json)
      : weatherId = json["id"],
        description = json["description"],
        icon = json["icon"];
}