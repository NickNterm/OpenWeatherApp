import 'package:flutter/material.dart';
import 'package:open_weather_app/color/colors.dart';
import 'package:open_weather_app/pages/loading/loading_page.dart';
import 'package:open_weather_app/providers/weekly_weather_codes_controller.dart';
import 'package:provider/provider.dart';
import 'package:open_weather_app/providers/current_data_controller.dart';
import 'package:open_weather_app/providers/hourly_temp_data_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HourlyTempDataController>(
            create: (context) => HourlyTempDataController()),
        ChangeNotifierProvider<CurrentDataController>(
            create: (context) => CurrentDataController()),
        ChangeNotifierProvider<WeeklyDataController>(
            create: (context) => WeeklyDataController()),
      ],
      child: MaterialApp(
        title: 'Open Weather',
        theme: ThemeData(
          brightness: Brightness.dark,
          backgroundColor: kbackgroundColor,
          scaffoldBackgroundColor: kbackgroundColor,
          fontFamily: 'Ubuntu',
        ),
        home: const LoadingScreen(),
      ),
    );
  }
}
