import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_app/models/convert_functions.dart';
import '../models/current_data.dart';

class CurrentDataController extends ChangeNotifier {
  bool _hasData = false;
  bool get hasData => _hasData;

  CurrentData? _currentData;
  CurrentData? get currentData => _currentData;

  Future<bool> getData(double lat, double long) async {
    String currentdataUrl =
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&timezone=Europe%2FMoscow&current_weather=true";
    var response = await http.get(Uri.parse(currentdataUrl));
    final data = json.decode(response.body);
    _currentData = CurrentData.fromApi(data);
    _hasData = true;
    return _hasData;
  }

  String getCurrentDataDescription() {
    return getWeatherDescriptionFromWeatherCode(_currentData!.weatherCode);
  }

  String getCurrentDataAssetName() {
    return getAssetNameFromWeatherCode(_currentData!.weatherCode);
  }

  double getCurrentTemp() {
    return _currentData!.temp;
  }
}
