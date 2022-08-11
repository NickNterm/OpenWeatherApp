import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:open_weather_app/color/colors.dart';
import 'package:open_weather_app/pages/main/components/bottom_list_view/components/hourly_horizontal_list_view/hourly_horizontal_list_view.dart';
import 'package:open_weather_app/pages/main/components/bottom_list_view/components/weekly_horizontal_list_view/weekly_horizontal_list_view.dart';

class BottomListView extends StatefulWidget {
  const BottomListView({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomListView> createState() => _BottomListViewState();
}

class _BottomListViewState extends State<BottomListView> {
  int selectedItemForListView = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterToggleTab(
          width: 70,
          height: 55,
          unSelectedBackgroundColors: const [kprimaryColor],
          selectedBackgroundColors: const [kbackgroundColor],
          borderRadius: 10,
          labels: const ["Hourly", "Next 7 Days"],
          selectedLabelIndex: (int num) {
            setState(() {
              selectedItemForListView = num;
            });
          },
          marginSelected: const EdgeInsets.all(5),
          selectedTextStyle: const TextStyle(
            color: kprimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          unSelectedTextStyle: const TextStyle(
              color: kbackgroundColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
          selectedIndex: selectedItemForListView,
        ),
        const SizedBox(height: 10),
        selectedItemForListView == 0
            ? const HourlyHorizontalListView()
            : const WeeklyHorizontalListView()
      ],
    );
  }
}
