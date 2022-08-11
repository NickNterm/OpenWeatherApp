import 'package:flutter/material.dart';
import 'package:open_weather_app/color/colors.dart';
import 'package:open_weather_app/providers/hourly_temp_data_controller.dart';
import 'package:provider/provider.dart';

class TitleAndMinMaxTemp extends StatelessWidget {
  const TitleAndMinMaxTemp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var day = 0;
    return Consumer<HourlyTempDataController>(
      builder: (context, value, child) {
        return Row(
          children: [
            const Text(
              "Today's Temprature",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
            const Spacer(),
            Text(
              value.getMinYSpotValue(day).toString() + "°C",
              style: const TextStyle(color: kprimaryColor),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "|",
              style: TextStyle(color: kprimaryColor),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              value.getMaxYSpotValue(day).toString() + "°C",
              style: const TextStyle(color: kprimaryColor),
            )
          ],
        );
      },
    );
  }
}
