//https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={long}&current_weather=true&timezone={tz}
class CurrentData {
  double temp;
  int weatherCode;

  CurrentData({required this.temp, required this.weatherCode});

  factory CurrentData.fromApi(Map map) {
    return CurrentData(
      temp: double.parse(map["current_weather"]["temperature"].toString()),
      weatherCode: map["current_weather"]["weathercode"].toInt(),
    );
  }
}
