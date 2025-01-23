import 'package:flutter/material.dart';
import 'package:frontend/pages/service_page.dart';
import 'package:frontend/providers/goals_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

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
      body: Stack(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //app bar
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                            _getGreeting(),
                            style: const TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(1, 104, 170, 1)),
                          ),
                          subtitle: const Text(
                            "Hussain",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(1, 104, 170, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.notifications),
                        ),
                      ),

                      // Balance Card
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: GestureDetector(
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
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
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
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        "15586 KWD",
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                  SizedBox(height: 50),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "5282 3456 7890 1289",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        "09/25",
                                        style: TextStyle(
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
                                label: const Text("Add money")),
                            ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.anchor_rounded),
                                label: const Text("Recieve"))
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Heading for Goals
                      // Heading for Goals
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text(
                                "Highlights",
                                style: TextStyle(
                                  fontSize: 25,
                                  // fontWeight: FontWeight.bold,
                                  color: titleTextColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Horizontal List of Goals
                      Container(
                        height: 150,
                        padding: const EdgeInsets.only(left: 10),
                        child: Consumer<GoalsProvider>(
                            builder: (context, provider, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.list.length,
                            itemBuilder: (context, index) {
                              var goal = provider.list[index];
                              return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  //color: const Color.fromARGB(255, 255, 179, 65),
                                  elevation: 5,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Event ${index + 1}",
                                          style: const TextStyle(
                                              //color: Colors.grey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "Duration: ${goal.duration} months",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 4),
                                        SizedBox(
                                          height: 5,
                                          width: 100,
                                          child: LinearProgressBar(
                                            maxSteps: 6,
                                            progressType: LinearProgressBar
                                                .progressTypeLinear,
                                            currentStep: index + 1,
                                            progressColor: Colors.red,
                                            backgroundColor: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
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
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ),
                      Consumer<GoalsProvider>(builder: (context, provider, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: (provider.list.length < 3)
                              ? provider.list.length
                              : 3,
                          itemBuilder: (context, index) {
                            var goal = provider.list[index];
                            return Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: const Icon(Icons.control_camera),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      goal.name,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Text('${goal.amount}/5000'),
                                  ],
                                ),
                                subtitle: SizedBox(
                                  height: 5,
                                  width: 10,
                                  child: LinearProgressBar(
                                    maxSteps: 5,
                                    progressType:
                                        LinearProgressBar.progressTypeLinear,
                                    currentStep: index + 1,
                                    progressColor:
                                        const Color.fromRGBO(0, 221, 163, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(223, 222, 222, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isFabClicked)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                          height:
                              100), // Adjust this value to move the buttons up or down
                      ElevatedButton(
                        onPressed: () {
                          // Handle Send Via WAMD button tap
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Send Via WAMD'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Transfer button tap
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Transfer'),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          setState(() {
            _isFabClicked = !_isFabClicked;
          });
        },
      ),
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
