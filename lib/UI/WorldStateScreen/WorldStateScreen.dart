import 'package:covid22222222222222222/UI/CountryListScreen/CountriesListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../Models/WorldStateModels.dart';
import 'worldStateController.dart';

class WorldStateScreen extends StatelessWidget {
  WorldStateScreen({super.key});

  final WorldStateController controller = Get.put(WorldStateController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
          child: GetBuilder<WorldStateController>(
            builder: (__) {
              if (__.worldStateModels == null) {
                return const Center(
                    child: SpinKitFadingCircle(
                  color: Colors.white,
                ));
              } else {
                final WorldStateModels data = __.worldStateModels!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * .10,
                      ),
                      PieChart(
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                        dataMap: {
                          "Total": data.cases!.toDouble(),
                          "Recovered": data.recovered!.toDouble(),
                          "Deaths": data.deaths!.toDouble(),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        chartRadius: Get.width * .30,
                        animationDuration: const Duration(milliseconds: 1500),
                        chartType: ChartType.ring,
                        colorList: const [
                          Color(0xff4285F4),
                          Color(0xff1aa260),
                          Color(0xffde5246),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * .05),
                        child: Column(
                          children: [
                            MyRow(title: 'Total', value: data.cases.toString()),
                            MyRow(
                                title: 'Today Deaths',
                                value: data.todayDeaths.toString()),
                            MyRow(
                                title: 'Today Recovered',
                                value: data.todayRecovered.toString()),
                            MyRow(
                                title: 'Deaths', value: data.deaths.toString()),
                            MyRow(
                                title: 'Active', value: data.active.toString()),
                            MyRow(
                                title: 'Critical',
                                value: data.critical.toString()),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(CountriesListScreen(),transition: Transition.downToUp);
                        },
                        child: Container(
                          height: Get.height * .06,
                          decoration: BoxDecoration(
                            color: const Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text(
                            'Track Countries',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      SizedBox(height: Get.height * .05)
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MyRow extends StatelessWidget {
  final String title, value;
  const MyRow({required this.title, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(value)
          ],
        ),
      ),
    );
  }
}
