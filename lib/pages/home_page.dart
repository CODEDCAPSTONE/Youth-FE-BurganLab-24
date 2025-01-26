import 'package:flutter/material.dart';
import 'package:frontend/pages/service_page.dart';
import 'package:frontend/providers/budget_provider.dart';
import 'package:frontend/providers/card_provider.dart';
import 'package:frontend/providers/goals_provider.dart';
import 'package:frontend/providers/targets_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:pie_chart/pie_chart.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFabClicked = false;

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

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
              child: Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // ignore: sort_child_properties_last
                  children: [
                    //app bar
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(_getGreeting(), style: const TextStyle(fontSize: 10, color: Color.fromRGBO(1, 104, 170, 1)),),
                        subtitle: const Text("Hussain", style: TextStyle(fontSize: 20, color: Color.fromRGBO(1, 104, 170, 1), fontWeight: FontWeight.bold),),
                        trailing: const Icon(Icons.notifications),
                      ),
                    ),
                            
                    // Balance Card
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,),
                      child: FutureBuilder(
                        future: context.read<VCardsProvider>().getVCards(),
                        builder: (context, dataSnapshot) {
                          if (dataSnapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
                          return Consumer<VCardsProvider>(
                            builder: (context, provider, _) {
                              if (provider.cards.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("No Cards found"),
                                );
                              }
                              return GestureDetector(
                                onTap: () async {
                                  // Handle balance card tap here
                                  print(provider.cards[0].cardNumber);
                                  await Provider.of<VCardsProvider>(context, listen: false).getTransactions(cardNumber: provider.cards[0].cardNumber);
                                  GoRouter.of(context).push('/cardDetails');
                                },
                                child: Card(
                                  elevation: 5,
                                  margin: const EdgeInsets.symmetric(horizontal: 32),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Current Balance",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "0514008001",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              "${provider.cards[0].balance} KWD",
                                              style: const TextStyle(
                                                fontSize: 28,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                        ),
                                        const SizedBox(height: 50),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${provider.cards[0].cardNumber}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Text(
                                              provider.cards[0].expiryDate,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          );
                        }
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Heading for Budget
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push('/budgetDetails');
                        },
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Budget",
                              style: TextStyle(
                                fontSize: 25,
                                // fontWeight: FontWeight.bold,
                                color: titleTextColor,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      padding: const EdgeInsets.symmetric(vertical: 24),
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
                              // print(provider.budget);
                              if (provider.budget.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 100),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.push('/setupBudget');
                                    }, 
                                    child: const Text("Setup Budget")
                                  ),
                                );
                              }
                              return PieChart(
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
                              );
                            }
                          );
                        }
                      ),
                    ),
                  const SizedBox(height: 18),
                            
                  // Heading for Goals
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        context.push('/targets');
                      },
                      child: Row(
                        children: [
                          Text(
                            "Targets",
                            style: TextStyle(
                              fontSize: 25,
                              // fontWeight: FontWeight.bold,
                              color: titleTextColor,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                    
                  // List of Goals
                  FutureBuilder(
                    future: context.read<TargetsProvider>().getTargets(),
                    builder: (context, dataSnapshot) {
                      if (dataSnapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
                      return Consumer<TargetsProvider>(
                        builder: (context, provider, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: (provider.targets.length < 3) ? provider.targets.length : 3,
                            itemBuilder: (context, index) {
                              var target = provider.targets[index];
                              return Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: const Icon(Icons.control_camera),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(target.targetName, style: const TextStyle(fontSize: 15),),
                                      Text('${target.totalAmount}/${target.balanceTarget}'),
                                    ],
                                  ),
                                  subtitle: SizedBox(
                                    height: 5,
                                    width: 10,
                                    child: LinearProgressBar(
                                      maxSteps: target.balanceTarget,
                                      progressType: LinearProgressBar
                                          .progressTypeLinear,
                                      currentStep: target.totalAmount,
                                      progressColor: const Color.fromRGBO(0, 221, 163, 1),
                                      backgroundColor: const Color.fromRGBO(223, 222, 222, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      );
                    }
                  ),
                  const SizedBox(height: 50,),
                  
                  ],
                )
              )
            )
          )
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context, 
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.push('/transfer');
                        Navigator.pop(context);
                      }, 
                      child: const Text("Transfer")
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.push('/link');
                        Navigator.pop(context);
                      }, 
                      child: const Text("Request Link")
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.push('/wamd');
                        Navigator.pop(context);
                      }, 
                      child: const Text("WAMD")
                    ),
                    const SizedBox(height: 150,),
                  ],
                );
              }
            );
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          child: const Icon(Icons.send, color: Colors.white),
        )
    );
  }
}
      


// New widget for the bottom navigation bar
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              context.go("/home");
            },
            iconSize: 30,
            icon: const Icon(Icons.home_filled),
          ),
          IconButton(
            onPressed: () {
              context.go("/loyalty");
            },
            iconSize: 30,
            icon: const Icon(Icons.discount),
          ),
          const SizedBox(
            width: 80,
          ),
          IconButton(
            onPressed: () {
              context.go("/service");
            },
            iconSize: 30,
            icon: const Icon(Icons.category_outlined),
          ),
          IconButton(
            onPressed: () {
              context.go("/more");
            },
            iconSize: 30,
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
    );
  }
}

// New widget for the floating action button
class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingActionButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      backgroundColor: Colors.blue,
      child: const Icon(Icons.send, color: Colors.white),
    );
  }
}
// We are with you brother, all the way. From: your brothers, we will always stand beside you.
