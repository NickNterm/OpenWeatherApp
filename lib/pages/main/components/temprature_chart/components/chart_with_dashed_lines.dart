import 'package:dotted_line/dotted_line.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:open_weather_app/color/colors.dart';
import 'package:open_weather_app/providers/hourly_temp_data_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ChartWthDashedLines extends StatefulWidget {
  const ChartWthDashedLines({
    Key? key,
  }) : super(key: key);

  @override
  State<ChartWthDashedLines> createState() => _ChartWthDashedLinesState();
}

class _ChartWthDashedLinesState extends State<ChartWthDashedLines> {
  var chartPaddingOnMinMax = 3; // +/- some C so that the chart doesnt go to end
  var xNowLine =
      DateTime.now().hour.toDouble() + DateTime.now().minute * 0.05 / 3;
  // the x of the vertical line that inticates now time ex. (13:30 >>>  13.5)
  var day = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          // GestureDetector(
          //   onTap: () {
          //     setState(() {
          //       day--;
          //     });
          //   },
          //   child: Text("<"),
          // ),
          const DottedLine(
            direction: Axis.vertical,
            dashColor: Colors.grey,
          ),
          Expanded(
            child: Consumer<HourlyTempDataController>(
                builder: (context, value, child) {
              return LineChart(
                LineChartData(
                  extraLinesData:
                      ExtraLinesData(extraLinesOnTop: true, verticalLines: [
                    VerticalLine(
                      x: xNowLine,
                      dashArray: [5, 10],
                      color: Colors.grey.withOpacity(0.2),
                    )
                  ]),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(),
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  minY: value.getMinYSpotValue(day) - chartPaddingOnMinMax,
                  maxY: value.getMaxYSpotValue(day) + chartPaddingOnMinMax,
                  lineBarsData: [
                    LineChartBarData(
                      barWidth: 5,
                      dotData: FlDotData(
                        show: true,
                        checkToShowDot: (flpoint, chart) {
                          return flpoint.x == 3 ||
                              flpoint.x == 9 ||
                              flpoint.x == 15 ||
                              flpoint.x == 21;
                        },
                      ),
                      color: ksecondaryColor,
                      belowBarData: BarAreaData(
                          show: true, color: ksecondaryColor.withOpacity(0.2)),
                      isStrokeCapRound: true,
                      spots: value.getFlSpotsFromTempDataByDay(day),
                      isCurved: true,
                    ),
                  ],
                ),
                swapAnimationDuration: const Duration(milliseconds: 150),
                swapAnimationCurve: Curves.linear,
              );
            }),
          ),
          const DottedLine(
            direction: Axis.vertical,
            dashColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
