import 'package:flutter/material.dart';
import 'package:open_weather_app/pages/main/components/bottom_list_view/bottom_list_view.dart';
import 'package:open_weather_app/pages/main/components/temprature_chart/todays_temprature_chart.dart';
import 'package:open_weather_app/pages/main/components/top_main_widget/top_main_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedUnit = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(height: 30),
              TopMainWidget(),
              SizedBox(height: 50),
              TodaysTempratureChart(),
              SizedBox(height: 40),
              BottomListView(),
            ],
          ),
        ),
      ),
    );
  }
}
