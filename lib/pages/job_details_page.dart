import 'package:flutter/material.dart';
import 'package:frontend/providers/budget_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class JobDetailsPage extends StatelessWidget {

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
                          "Burgan HQ",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(1, 104, 170, 1),
                          ),
                        ),
                    // actions: [
                    //   IconButton(onPressed: () => context.push('/setupBudget'), icon: const Icon(Icons.edit))
                    // ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.all(50),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Image.asset(
                            'assets/images/burgan-bank-logo.png',
                            height: 200,
                            width: 200,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Card(
                          elevation: 5,
                          child: Container(
                            // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Description:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                const SizedBox(height: 100,)
                              ],
                            )
                          ),
                        ),
                        const SizedBox(height: 130,),
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