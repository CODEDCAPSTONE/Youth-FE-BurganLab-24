import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'dart:ui';

import 'package:frontend/models/card.dart';
import 'package:frontend/providers/card_provider.dart';
import 'package:provider/provider.dart';

class AccountDropdown extends StatefulWidget {
  @override
  _AccountDropdownState createState() => _AccountDropdownState();
}

class _AccountDropdownState extends State<AccountDropdown> with SingleTickerProviderStateMixin {
  bool isOpen = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Map<String, String>> accounts = [
    {'name': 'Current account', 'number': '12346758927489', 'balance': '1000.00 KD'},
    // {'name': 'Savings account', 'number': '98765432101234', 'balance': '5000.00 KD'},
    // {'name': 'Business account', 'number': '11223344556677', 'balance': '7500.00 KD'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      isOpen = !isOpen;
      if (isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final VCard card = context.read<VCardsProvider>().cards[0];
    return Stack(
      children: [
        if (isOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleDropdown,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Container(
                  // color: Colors.black.withOpacity(1),
                ),
              ),
            ),
          ),
        Column(
          children: [
            GestureDetector(
              onTap: _toggleDropdown,
              child: Container(
                constraints: const BoxConstraints(minWidth: 321),
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFdfdede)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(""),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Current account',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                card.cardNumber.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF868484),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            card.balance!.toStringAsFixed(3),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0168aa),
                            ),
                          ),
                          const SizedBox(width: 8),
                          RotationTransition(
                            turns: Tween(begin: 0.0, end: 0.5).animate(_animation),
                            child: const Icon(Icons.arrow_drop_down),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: _animation,
              axisAlignment: -1.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFdfdede)),
                ),
                child: Column(
                  children: accounts.skip(1).map((account) {
                    return ListTile(
                      title: Text(account['name']!),
                      subtitle: Text(account['number']!),
                      trailing: Text(account['balance']!),
                      onTap: () {
                        // Handle account selection
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

