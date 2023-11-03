class WeatherModel {
  final List<WeatherDetail> weather;
  final double temp, feelTemp, minTemp, maxTemp;
  final int id, pressure, humidity, windDeg;
  final dynamic windSpeed;
  final String cityName;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : weather = (json["weather"] as List<dynamic>)
            .map((weatherJson) => WeatherDetail.fromJson(weatherJson))
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

class WeatherDetail {
  final int weatherId;
  final String description, icon;

  WeatherDetail.fromJson(Map<String, dynamic> json)
      : weatherId = json["id"],
        description = json["description"],
        icon = json["icon"];
}
