import 'package:flutter/material.dart';
import 'package:frontend/providers/budget_provider.dart';
import 'package:frontend/providers/card_provider.dart';
import 'package:frontend/providers/goals_provider.dart';
import 'package:frontend/providers/targets_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 0;

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
        // drawer: Drawer(
        //     child: FutureBuilder(
        //         future: context.read<AuthProvider>().initAuth(),
        //         builder: (context, snapshot) {
        //           return ListView(
        //             children: [
        //               Container(
        //                 decoration: BoxDecoration(color: Colors.orange),
        //                 //margin: EdgeInsets.all(8.0),
        //                 padding:
        //                     EdgeInsets.only(top: 100, bottom: 10, left: 10),
        //                 child: Row(
        //                   children: [
        //                     //Icon(Icons.person),
        //                     Text(
        //                       "Welcome User",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               ListTile(
        //                 title: Text("Profile"),
        //                 leading: Icon(Icons.person),
        //                 onTap: () {
        //                   GoRouter.of(context).push('/profile');
        //                 },
        //               ),
        //               ListTile(
        //                 title: Text("Branches"),
        //                 leading: Icon(Icons.location_on_outlined),
        //                 onTap: () {
        //                   GoRouter.of(context).push('/branches');
        //                 },
        //               ),
        //               ListTile(
        //                 title: Text("Help and Services"),
        //                 leading: Icon(Icons.headphones),
        //                 onTap: () {
        //                   GoRouter.of(context).push('/help');
        //                 },
        //               ),
        //               ListTile(
        //                 title: Text(
        //                   "Log out",
        //                   style: TextStyle(color: Colors.red),
        //                 ),
        //                 leading: Icon(Icons.logout),
        //                 onTap: () {
        //                   context.read<AuthProvider>().logout();
        //                   GoRouter.of(context).go('/');
        //                 },
        //               ),
        //               // Container(
        //               //   alignment: Alignment.bottomLeft,
        //               //   child: Icon(Icons.settings),
        //               // )
        //             ],
        //           );
        //         })
        //     // FutureBuilder(
        //     //     future: context.watch<AuthProvider>().initAuth(),
        //     //     builder: (context, snapshot) {
        //     //       return Consumer<AuthProvider>(builder: (context, provider, _) {
        //     //         return (provider.isAuth())
        //     //             ? ListView(
        //     //                 padding: EdgeInsets.zero,
        //     //                 children: [
        //     //                   Text(
        //     //                     "Welcome ${provider.user!.email}",
        //     //                   ),
        //     //                   ListTile(
        //     //                     title: Text("Log out"),
        //     //                     trailing: const Icon(Icons.how_to_reg),
        //     //                     onTap: () {
        //     //                       provider.logout();
        //     //                       GoRouter.of(context).go('/');
        //     //                     },
        //     //                   ),
        //     //                   ListTile(
        //     //                     title: Text("Profile"),
        //     //                     trailing: const Icon(Icons.how_to_reg),
        //     //                     onTap: () {
        //     //                       GoRouter.of(context).push('/profile');
        //     //                     },
        //     //                   )
        //     //                 ],
        //     //               )
        //     //             : ListView(
        //     //                 children: [
        //     //                   GestureDetector(
        //     //                     onTap: () {
        //     //                       GoRouter.of(context).push('/login');
        //     //                     },
        //     //                     child: const ListTile(
        //     //                       title: Text("Login"),
        //     //                     ),
        //     //                   ),
        //     //                   GestureDetector(
        //     //                     onTap: () {
        //     //                       GoRouter.of(context).push('/signup');
        //     //                     },
        //     //                     child: ListTile(
        //     //                       title: Text("Sign up"),
        //     //                     ),
        //     //                   ),
        //     //                 ],
        //     //               );
        //     //       });
        //     //     }),
        //     ),
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
                  children: [
                    //app bar
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Good Morning", style: TextStyle(fontSize: 10, color: Color.fromRGBO(1, 104, 170, 1)),),
                        subtitle: Text("Hussain", style: TextStyle(fontSize: 20, color: Color.fromRGBO(1, 104, 170, 1), fontWeight: FontWeight.bold),),
                        trailing: Icon(Icons.notifications),
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
                              return GestureDetector(
                                onTap: () {
                                  // Handle balance card tap here
                                  GoRouter.of(context).push('/main', extra: 0);
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
                            
                    //Quick Actions
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            iconAlignment: IconAlignment.end,
                            icon: const Icon(Icons.add_circle_outline), 
                            label: const Text("Add money")
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.anchor_rounded), 
                            label: const Text("Recieve")
                          )
                        ],
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
                  const SizedBox(height: 8),

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
                            if (provider.budget.length == 0) return const Text("Nothing");
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

                  // Horizontal List of Events
                  // Container(
                  //   height: 150,
                  //   padding: const EdgeInsets.only(left: 10),
                  //   child: Consumer<GoalsProvider>(
                  //       builder: (context, provider, _) {
                  //         return ListView.builder(
                  //           shrinkWrap: true,
                  //           scrollDirection: Axis.horizontal,
                  //           itemCount: provider.list.length,
                  //           itemBuilder: (context, index) {
                  //             var goal = provider.list[index];
                  //             return GestureDetector(
                  //               onTap: () {},
                  //               child: Card(
                  //                 //color: const Color.fromARGB(255, 255, 179, 65),
                  //                 elevation: 5,
                  //                 margin: const EdgeInsets.symmetric(
                  //                     horizontal: 8.0, vertical: 8.0),
                  //                 child: Container(
                  //                   margin: const EdgeInsets.only(bottom: 20),
                  //                   padding: const EdgeInsets.symmetric(
                  //                       horizontal: 10, vertical: 8),
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Text(
                  //                         "Event ${index+1}",
                  //                         style: const TextStyle(
                  //                             //color: Colors.grey,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                         textAlign: TextAlign.center,
                  //                       ),
                  //                       Text(
                  //                         "Duration: ${goal.duration} months",
                  //                         style: const TextStyle(fontSize: 14),
                  //                       ),
                  //                       const SizedBox(height: 4),
                  //                       SizedBox(
                  //                         height: 5,
                  //                         width: 100,
                  //                         child: LinearProgressBar(
                  //                           maxSteps: 6,
                  //                           progressType: LinearProgressBar
                  //                               .progressTypeLinear,
                  //                           currentStep: index + 1,
                  //                           progressColor: Colors.red,
                  //                           backgroundColor: Colors.grey,
                  //                           borderRadius: BorderRadius.circular(10),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         );
                  //   }),
                  // ),
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
                                        maxSteps: int.parse(target.balanceTarget),
                                        progressType: LinearProgressBar
                                            .progressTypeLinear,
                                        currentStep: int.parse(target.totalAmount),
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
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                iconSize: 30,
                icon: const Icon(Icons.home_filled),
              ),
              IconButton(
                onPressed: () {},
                iconSize: 30,
                icon: const Icon(Icons.discount),
              ),
              const SizedBox(width: 80,),
              IconButton(
                onPressed: () {},
                iconSize: 30,
                icon: const Icon(Icons.category_outlined),
              ),
              IconButton(
                onPressed: () {},
                iconSize: 30,
                icon: const Icon(Icons.more_horiz_rounded),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/transfer');
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          // foregroundColor: Colors.black,
          child: const Icon(Icons.send, color: Colors.white),
        ),
      );
  }
}
// We are with you brother, all the way. From: your brothers, we will always stand beside you.
