class HourlyTempData {
  List<double> temps = [];
  List<String> time = [];
  List<int> weatherCodes = [];

  HourlyTempData(
      {required this.temps, required this.time, required this.weatherCodes});

  factory HourlyTempData.fromApi(Map map) {
    List<double> tempList = [];
    for (var i in map["hourly"]["temperature_2m"]) {
      tempList.add(i.toDouble());
    }

    List<String> timeList = [];
    for (var i in map["hourly"]["time"]) {
      timeList.add(i.toString());
    }

    List<int> weathercodeList = [];
    for (var i in map["hourly"]["weathercode"]) {
      weathercodeList.add(i.toInt());
    }

    return HourlyTempData(
      temps: tempList,
      time: timeList,
      weatherCodes: weathercodeList,
    );
  }
}
