import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/loyalty_page.dart';
import 'package:frontend/pages/more_page.dart';
import 'package:frontend/pages/service_page.dart';
import 'package:go_router/go_router.dart';


class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // bool _isFabClicked = false;

  int selectedIndex = 0;

  List pages = [
    HomePage(),
    LoyaltyPage(),
    const ServicePage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    // var brightness = View.of(context).platformDispatcher.platformBrightness;
    // bool isDarkMode = brightness == Brightness.dark;
    // // print(isDarkMode);
    // Color titleTextColor = (isDarkMode) ? Colors.white : Colors.black;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(239, 238, 238, 1),
        body: pages[selectedIndex],
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() => selectedIndex = 0);
                  // context.go("/home");
                },
                iconSize: 30,
                icon: const Icon(Icons.home_filled),
              ),
              IconButton(
                onPressed: () {
                  setState(() => selectedIndex = 1);
                  // context.go("/loyalty");
                },
                iconSize: 30,
                icon: const Icon(Icons.discount),
              ),
              const SizedBox(
                width: 80,
              ),
              IconButton(
                onPressed: () {
                  setState(() => selectedIndex = 2);
                  // context.go("/service");
                },
                iconSize: 30,
                icon: const Icon(Icons.category_outlined),
              ),
              IconButton(
                onPressed: () {
                  setState(() => selectedIndex = 3);
                  // context.go("/more");
                },
                iconSize: 30,
                icon: const Icon(Icons.more_horiz_rounded),
              ),
            ],
          ),
        ),
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