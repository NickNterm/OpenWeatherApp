import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:open_weather_app/pages/main/components/bottom_list_view/components/hourly_horizontal_list_view/components/hourly_horizontal_list_view_item.dart';
import 'package:open_weather_app/providers/hourly_temp_data_controller.dart';
import 'package:provider/provider.dart';

class HourlyHorizontalListView extends StatefulWidget {
  const HourlyHorizontalListView({
    Key? key,
  }) : super(key: key);

  @override
  State<HourlyHorizontalListView> createState() =>
      _HourlyHorizontalListViewState();
}

class _HourlyHorizontalListViewState extends State<HourlyHorizontalListView> {
  ScrollController listViewController = ScrollController();
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      for (var i = 0;
          i < context.read<HourlyTempDataController>().getTimestamps(0).length;
          i++) {
        if (DateTime.parse(context
                    .read<HourlyTempDataController>()
                    .getTimestamps(0)[i])
                .hour ==
            DateTime.now().hour) {
          listViewController.animateTo(i * 100.toDouble(),
              duration: const Duration(seconds: 1), curve: Curves.ease);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HourlyTempDataController>(
      builder: (BuildContext context, value, Widget? child) {
        return SizedBox(
          height: 150,
          child: ListView.builder(
            controller: listViewController,
            itemCount: value.getTimestamps(0).length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              List<String> times = value.getTimestamps(0);
              List<double> temps = value.getTempratures(0);
              List<int> weathercodes = value.getWeatherCodes(0);

              return ShowHourlyInfoTile(
                time: times[index],
                weathercode: weathercodes[index],
                temp: temps[index],
              );
            },
          ),
        );
      },
    );
  }
}
