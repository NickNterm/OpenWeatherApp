class WeeklyWeatherCodes {
  List<String> time = [];
  List<int> weatherCodes = [];
  List<DateTime> sunsets = [];
  List<DateTime> sunrises = [];

  WeeklyWeatherCodes(
      {required this.time,
      required this.weatherCodes,
      required this.sunrises,
      required this.sunsets});
  factory WeeklyWeatherCodes.fromApi(Map map) {
    List<String> timeList = [];
    for (var i in map["daily"]["time"]) {
      timeList.add(i.toString());
    }

    List<int> weathercodeList = [];
    for (var i in map["daily"]["weathercode"]) {
      weathercodeList.add(i.toInt());
    }

    List<DateTime> sunsetsList = [];
    for (var i in map["daily"]["sunset"]) {
      sunsetsList.add(DateTime.parse(i));
    }

    List<DateTime> sunrisesList = [];
    for (var i in map["daily"]["sunrise"]) {
      sunrisesList.add(DateTime.parse(i));
    }

    return WeeklyWeatherCodes(
      time: timeList,
      weatherCodes: weathercodeList,
      sunrises: sunrisesList,
      sunsets: sunsetsList,
    );
  }
}
