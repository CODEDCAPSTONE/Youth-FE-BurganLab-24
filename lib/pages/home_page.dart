import 'package:flutter/material.dart';
import 'package:frontend/providers/goals_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE5F1F9),
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
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //app bar
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Good Morning", style: TextStyle(fontSize: 10),),
                      subtitle: Text("Hussain", style: TextStyle(fontSize: 20),),
                      trailing: Icon(Icons.notifications),
                    ),
                  ),

                  // Balance Card
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                          padding: const EdgeInsets.all(16.0),
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
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
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

                  // Heading for Goals
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        
                      },
                      child: const Row(
                        children: [
                          Text(
                            "Goals",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<GoalsProvider>(
                    builder: (context, provider, _) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.list.length,
                        itemBuilder: (context, index) {
                          var goal = provider.list[index];
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
                                  Text(goal.name, style: const TextStyle(fontSize: 15),),
                                  Text('${goal.amount}/5000'),
                                ],
                              ),
                              subtitle: SizedBox(
                                height: 5,
                                width: 10,
                                child: LinearProgressBar(
                                  maxSteps: 5,
                                  progressType: LinearProgressBar
                                      .progressTypeLinear,
                                  currentStep: index + 1,
                                  progressColor: Colors.lightGreen,
                                  backgroundColor: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                iconSize: 50,
                icon: const Icon(Icons.home),
              ),
              const SizedBox(width: 100,),
              IconButton(
                onPressed: () {},
                iconSize: 50,
                icon: const Icon(Icons.currency_bitcoin),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          // foregroundColor: Colors.black,
          child: const Icon(Icons.send, color: Colors.white),
        ),
      );
  }
}
