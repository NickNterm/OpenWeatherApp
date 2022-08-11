import 'package:flutter/material.dart';
import 'package:open_weather_app/pages/main/components/bottom_list_view/components/weekly_horizontal_list_view/components/weekly_horizontal_list_view_item.dart';
import 'package:open_weather_app/providers/hourly_temp_data_controller.dart';
import 'package:open_weather_app/providers/weekly_weather_codes_controller.dart';
import 'package:provider/provider.dart';

class WeeklyHorizontalListView extends StatelessWidget {
  const WeeklyHorizontalListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<WeeklyDataController, HourlyTempDataController>(
      builder: (BuildContext context, weeklyValue, hourlyValue, Widget? child) {
        return SizedBox(
          height: 150,
          child: ListView.builder(
            itemCount: weeklyValue.getTimestamps().length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              List<String> times = weeklyValue.getTimestamps();
              List<int> weathercodes = weeklyValue.getWeatherCodes();

              return ShowWeeklyInfoTile(
                time: times[index],
                weathercode: weathercodes[index],
                temp: hourlyValue.getAverageTemp(index),
              );
            },
          ),
        );
      },
    );
  }
}
