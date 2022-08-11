import 'package:flutter/material.dart';
import 'package:open_weather_app/pages/main/components/temprature_chart/components/chart_bottom_row.dart';
import 'package:open_weather_app/pages/main/components/temprature_chart/components/chart_with_dashed_lines.dart';
import 'package:open_weather_app/pages/main/components/temprature_chart/components/title_with_min_max_temp.dart';

class TodaysTempratureChart extends StatelessWidget {
  const TodaysTempratureChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TitleAndMinMaxTemp(),
          SizedBox(
            height: 10,
          ),
          ChartWthDashedLines(),
          SizedBox(
            height: 10,
          ),
          ChartBottomRow(),
        ],
      ),
    );
  }
}
