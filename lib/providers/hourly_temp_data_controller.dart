import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_app/models/hourly_temp_data.dart';

class HourlyTempDataController extends ChangeNotifier {
  bool _hasData = false;
  bool get hasData => _hasData;

  HourlyTempData? _hourlyTempData;
  HourlyTempData? get hourlyTempData => _hourlyTempData;

  Future<bool> getData(double lat, double long) async {
    String currentdataUrl =
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&hourly=temperature_2m,weathercode&timezone=Europe%2FMoscow";
    var response = await http.get(Uri.parse(currentdataUrl));
    final data = json.decode(response.body);
    _hourlyTempData = HourlyTempData.fromApi(data);
    _hasData = true;
    notifyListeners();
    return _hasData;
  }

  double getMinYSpotValue(int day) {
    double min = _hourlyTempData!.temps[day * 24];
    for (int i = 0; i < 24; i++) {
      if (_hourlyTempData!.temps[i + day * 24] < min) {
        min = _hourlyTempData!.temps[i + day * 24];
      }
    }
    return min;
  }

  double getMaxYSpotValue(int day) {
    double max = _hourlyTempData!.temps[day * 24];
    for (int i = 0; i < 24; i++) {
      if (_hourlyTempData!.temps[i + day * 24] > max) {
        max = _hourlyTempData!.temps[i + day * 24];
      }
    }
    return max;
  }

  List<FlSpot> getFlSpotsFromTempDataByDay(int day) {
    List<FlSpot> list = [];
    for (int i = 0; i < 24; i++) {
      list.add(FlSpot(i + day * 24, _hourlyTempData!.temps[i + day * 24]));
    }
    return list;
  }

  List<double> getTempratures(int day) {
    return _hourlyTempData!.temps.take(24 + 24 * day).toList();
  }

  List<String> getTimestamps(int day) {
    return _hourlyTempData!.time.take(24 + 24 * day).toList();
  }

  List<int> getWeatherCodes(int day) {
    return _hourlyTempData!.weatherCodes.take(24 + 24 * day).toList();
  }

  double getAverageTemp(int day) {
    double sum = 0;
    for (var temp in _hourlyTempData!.temps.getRange(24 * day, 24 + day * 24)) {
      sum += temp;
    }
    double d = sum / 24;
    String inString = d.toStringAsFixed(1);
    double inDouble = double.parse(inString);
    return inDouble;
  }

  List<double> getWeeklyTemps() {
    List<double> temps = [];
    for (int i = 0; i < 7; i++) {
      temps.add(getAverageTemp(i));
    }
    return temps;
  }
}
