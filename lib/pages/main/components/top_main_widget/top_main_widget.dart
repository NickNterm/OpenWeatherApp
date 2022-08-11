import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:open_weather_app/color/colors.dart';
import 'package:open_weather_app/providers/current_data_controller.dart';
import 'package:open_weather_app/providers/weekly_weather_codes_controller.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class TopMainWidget extends StatelessWidget {
  const TopMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentDataController>(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WebsafeSvg.asset(
                  "assets/weather_icons/" + value.getCurrentDataAssetName(),
                  height: 75,
                  fit: BoxFit.cover,
                  color: ksecondaryColor,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  value.getCurrentTemp().toString() + "°C",
                  style: const TextStyle(
                      color: kprimaryColor,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Text(
              value.getCurrentDataDescription(),
              style: const TextStyle(
                  color: kprimaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WebsafeSvg.asset(
                        "assets/weather_icons/sunrise.svg",
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        color: ksecondaryColor,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          const Text(
                            "Sunrise",
                            style: TextStyle(
                                color: kprimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            DateFormat('kk:mm').format(
                                Provider.of<WeeklyDataController>(context)
                                    .weeklyWeatherCodes!
                                    .sunrises[0]),
                            style: const TextStyle(color: ksecondaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 5,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kprimaryColor,
                  ),
                ),
                Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WebsafeSvg.asset(
                          "assets/weather_icons/sunset.svg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: ksecondaryColor,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            const Text(
                              "Sunset",
                              style: TextStyle(
                                  color: kprimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              DateFormat('kk:mm').format(
                                  Provider.of<WeeklyDataController>(context)
                                      .weeklyWeatherCodes!
                                      .sunsets[0]),
                              style: const TextStyle(color: ksecondaryColor),
                            ),
                          ],
                        ),
                      ]),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
