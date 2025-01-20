import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:pie_chart/pie_chart.dart';

class BudgetDetails extends StatelessWidget {

  Map<String, double> dataMap = {
    "Shopping": 5,
    "Online Shopping": 3,
    "Dining": 3,
    "Fuel": 3,
    "Super Market": 2,
    "Entertainment": 2,
  };
  
  @override
    Widget build(BuildContext context) {
    var brightness = View.of(context).platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    // print(isDarkMode);
    Color titleTextColor = (isDarkMode) ? Colors.white : Colors.black;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 238, 238, 1),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const SizedBox(height: 100,),
                  AppBar(
                    forceMaterialTransparency: true,
                    title: const Text(
                          "Budget",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(1, 104, 170, 1),
                          ),
                        ),
                    actions: [
                      IconButton(onPressed: () => context.push('/setupBudget'), icon: const Icon(Icons.edit))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PieChart(
                                dataMap: dataMap,
                                animationDuration: const Duration(milliseconds: 800),
                                chartLegendSpacing: 32,
                                chartRadius: MediaQuery.of(context).size.width / 3.2,
                                // colorList: colorList,
                                initialAngleInDegree: 0,
                                chartType: ChartType.ring,
                                ringStrokeWidth: 32,
                                centerText: "Budget",
                                legendOptions: const LegendOptions(
                                  showLegendsInRow: false,
                                  legendPosition: LegendPosition.right,
                                  // showLegends: true,
                                  // legendShape: _BoxShape.circle,
                                  legendTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                chartValuesOptions: const ChartValuesOptions(
                                  // showChartValueBackground: true,
                                  // showChartValues: true,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 1,
                                ),
                                // gradientList: ---To add gradient colors---
                                // emptyColorGradient: ---Empty Color gradient---
                              ),
                              const SizedBox(height: 50,),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Details",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(1, 104, 170, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    createTile(title: "Shopping", limit: 50, amountLeft: 27),
                                    createTile(title: "Online Shopping", limit: 50, amountLeft: 27),
                                    createTile(title: "Dining", limit: 70, amountLeft: 10),
                                    createTile(title: "Fuel", limit: 30, amountLeft: 12.9),
                                    createTile(title: "Super Market", limit: 100, amountLeft: 45.5),
                                    createTile(title: "Entertainment", limit: 50, amountLeft: 18),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ],
              )
              ),
            ),
          ),
        );
  }
}

Widget createTile({required String title, required int limit, required double amountLeft}) {
  return ListTile(
    title: Text(title, style: const TextStyle(fontSize: 15),),
    subtitle: SizedBox(
      height: 5,
      width: 10,
      child: LinearProgressBar(
        maxSteps: 100,
        progressType: LinearProgressBar
            .progressTypeLinear,
        currentStep: (amountLeft / limit * 100).toInt(),
        progressColor: Colors.blue.shade800,
        backgroundColor: const Color.fromRGBO(223, 222, 222, 1),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    trailing: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$limit KD', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
        Text('Left $amountLeft KD', style: const TextStyle(fontSize: 12),)
      ],
    ),
  );
}