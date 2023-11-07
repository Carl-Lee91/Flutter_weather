class AirPollutionModel {
  final List<AirPollutionDetail> airPollution;

  AirPollutionModel.fromJson(Map<String, dynamic> json)
      : airPollution = (json["list"] as List<dynamic>)
            .map((airPollutionJson) =>
                AirPollutionDetail.fromJson(airPollutionJson))
            .toList();
}

class AirPollutionDetail {
  final num pm2_5, pm10;

  AirPollutionDetail.fromJson(Map<String, dynamic> json)
      : pm2_5 = json["components"]["pm2_5"],
        pm10 = json["components"]["pm10"];
}
