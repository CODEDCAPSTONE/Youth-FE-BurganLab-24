import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/providers/budget_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class BudgetDetails extends StatelessWidget {

  Map<String, double> dataMap = {
    "Online Shopping": 3,
    "Dining": 3,
    "Fuel": 3,
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
                          child: FutureBuilder(
                            future: context.read<BudgetProvider>().getBudget(),
                            builder: (context, dataSnapshot) {
                              if (dataSnapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
                              return Consumer<BudgetProvider>(
                                builder: (context, provider, _) {
                                  return Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      PieChart(
                                        dataMap: {
                                          "Online Shopping": provider.budget[0]["limit"].toDouble(),
                                          "Dining": provider.budget[1]["limit"].toDouble(),
                                          "Fuel": provider.budget[2]["limit"].toDouble(),
                                          "Entertainment": provider.budget[3]["limit"].toDouble(),
                                        },
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
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: provider.budget.length,
                                          itemBuilder: (context, index) {
                                            return createTile(
                                              title: provider.budget[index]["category"], 
                                              total: provider.budget[index]["total"], 
                                              limit: provider.budget[index]["limit"]
                                            );
                                          }
                                        )
                                      ),
                                    ],
                                  );
                                }
                              );
                            }
                          ),
                        ),
                        const SizedBox(height: 130,)
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

Widget createTile({required String title, required int total, required int limit}) {
  return ListTile(
    title: Text(title, style: const TextStyle(fontSize: 15),),
    subtitle: SizedBox(
      height: 5,
      width: 10,
      child: LinearProgressBar(
        maxSteps: 100,
        progressType: LinearProgressBar
            .progressTypeLinear,
        currentStep: (total / limit * 100).toInt(),
        progressColor: Colors.blue.shade800,
        backgroundColor: const Color.fromRGBO(223, 222, 222, 1),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    trailing: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$total KD', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
        Text('Limit $limit KD', style: const TextStyle(fontSize: 12),)
      ],
    ),
  );
}