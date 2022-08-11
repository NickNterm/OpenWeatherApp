import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:open_weather_app/color/colors.dart';
import 'package:open_weather_app/pages/main/home_page.dart';
import 'package:open_weather_app/providers/current_data_controller.dart';
import 'package:open_weather_app/providers/hourly_temp_data_controller.dart';
import 'package:open_weather_app/providers/weekly_weather_codes_controller.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getValues();
  }

  void getValues() async {
    try {
      double lat = 39.644375691782756;
      double long = 20.868500558926513;
      Location location = Location();
      bool _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          const snackBar = SnackBar(
            content: Text('Enable location to get the app work properly'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
      }

      PermissionStatus _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          const snackBar = SnackBar(
            content: Text('Grant permissions to get the app working'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
      }

      final _locationData = await location.getLocation();
      lat = _locationData.latitude!;
      long = _locationData.longitude!;
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        bool hourlyTempData =
            await context.read<HourlyTempDataController>().getData(lat, long);
        bool currentData =
            await context.read<CurrentDataController>().getData(lat, long);
        bool weeklyData =
            await context.read<WeeklyDataController>().getData(lat, long);
        if (hourlyTempData && currentData && weeklyData) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        }
      } else {
        const snackBar = SnackBar(
          content: Text('Check Your internet connection and relaunch the app'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
      getValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/app_icons/moon_sun_outline.png"),
            const Text(
              "Weather App",
              style: TextStyle(
                  fontSize: 25,
                  color: kprimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const SpinKitPulse(color: kprimaryColor),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
