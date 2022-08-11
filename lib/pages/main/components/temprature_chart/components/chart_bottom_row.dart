import 'package:flutter/material.dart';
import 'package:open_weather_app/color/colors.dart';
import 'package:open_weather_app/providers/hourly_temp_data_controller.dart';
import 'package:provider/provider.dart';

class ChartBottomRow extends StatelessWidget {
  const ChartBottomRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var day = 0;
    var titleTextStyle = const TextStyle(
      fontSize: 17,
      color: kprimaryColor,
      fontWeight: FontWeight.w600,
    );
    var subtitleTextStyle =
        const TextStyle(color: ksecondaryColor, fontWeight: FontWeight.w600);
    return Consumer<HourlyTempDataController>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "Overnight",
                  style: titleTextStyle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  value.getFlSpotsFromTempDataByDay(day)[3].y.toString() + "°C",
                  style: subtitleTextStyle,
                )
              ],
            ),
            Column(
              children: [
                Text("Morning", style: titleTextStyle),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  value.getFlSpotsFromTempDataByDay(day)[9].y.toString() + "°C",
                  style: subtitleTextStyle,
                )
              ],
            ),
            Column(
              children: [
                Text("Afternoon", style: titleTextStyle),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  value.getFlSpotsFromTempDataByDay(day)[15].y.toString() +
                      "°C",
                  style: subtitleTextStyle,
                )
              ],
            ),
            Column(
              children: [
                Text("Evening", style: titleTextStyle),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  value.getFlSpotsFromTempDataByDay(day)[21].y.toString() +
                      "°C",
                  style: subtitleTextStyle,
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
