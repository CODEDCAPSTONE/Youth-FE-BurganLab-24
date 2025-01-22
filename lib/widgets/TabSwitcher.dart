import 'package:flutter/material.dart';

class TabSwitcher extends StatefulWidget {
  @override
  _TabSwitcherState createState() => _TabSwitcherState();
}

class _TabSwitcherState extends State<TabSwitcher> with SingleTickerProviderStateMixin {
  bool isLocal = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleTab() {
    setState(() {
      isLocal = !isLocal;
      if (isLocal) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 71,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                left: _animation.value * (MediaQuery.of(context).size.width / 2 - 32),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2 - 32,
                  height: 57,
                  margin: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0168aa),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: isLocal ? null : _toggleTab,
                  child: Center(
                    child: Text(
                      'Local',
                      style: TextStyle(
                        color: isLocal ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: isLocal ? _toggleTab : null,
                  child: Center(
                    child: Text(
                      'International',
                      style: TextStyle(
                        color: isLocal ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}