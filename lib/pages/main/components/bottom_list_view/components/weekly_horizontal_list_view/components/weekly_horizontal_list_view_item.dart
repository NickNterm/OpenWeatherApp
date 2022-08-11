import 'package:flutter/material.dart';
import 'package:open_weather_app/color/colors.dart';
import 'package:open_weather_app/models/convert_functions.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ShowWeeklyInfoTile extends StatelessWidget {
  const ShowWeeklyInfoTile({
    Key? key,
    required this.time,
    required this.weathercode,
    required this.temp,
  }) : super(key: key);

  final String time;
  final int weathercode;
  final double temp;

  @override
  Widget build(BuildContext context) {
    var isNow = DateTime.now().day == DateTime.parse(time).day;
    return Container(
      padding: const EdgeInsets.all(10),
      width: 80,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isNow ? ksecondaryColor : kbackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isNow
              ? const Text(
                  "Today",
                  style: TextStyle(
                      color: kbackgroundColor, fontWeight: FontWeight.bold),
                )
              : Text(
                  DateTime.parse(time).day.toString() +
                      "/" +
                      DateTime.parse(time).month.toString(),
                  style: const TextStyle(
                      color: kprimaryColor, fontWeight: FontWeight.bold),
                ),
          WebsafeSvg.asset(
            "assets/weather_icons/" + getAssetNameFromWeatherCode(weathercode),
            color: !isNow ? kprimaryColor : kbackgroundColor,
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          Text(
            temp.toString() + "°C",
            style: TextStyle(
                color: !isNow ? kprimaryColor : kbackgroundColor,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
