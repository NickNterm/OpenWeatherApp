import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:open_weather_app/models/weekly_weather_codes.dart';
import 'package:http/http.dart' as http;

class WeeklyDataController extends ChangeNotifier {
  bool _hasData = false;
  bool get hasData => _hasData;

  WeeklyWeatherCodes? _weeklyWeatherCodes;
  WeeklyWeatherCodes? get weeklyWeatherCodes => _weeklyWeatherCodes;

  Future<bool> getData(double lat, double long) async {
    String currentdataUrl =
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&daily=weathercode,sunset,sunrise&timezone=Europe%2FBerlin";
    var response = await http.get(Uri.parse(currentdataUrl));
    final data = json.decode(response.body);
    _weeklyWeatherCodes = WeeklyWeatherCodes.fromApi(data);
    _hasData = true;
    notifyListeners();
    return _hasData;
  }

  List<int> getWeatherCodes() {
    return _weeklyWeatherCodes!.weatherCodes;
  }

  List<String> getTimestamps() {
    return _weeklyWeatherCodes!.time;
  }
}
