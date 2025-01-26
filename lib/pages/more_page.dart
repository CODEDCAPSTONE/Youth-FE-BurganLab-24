import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool isBiometricEnabled = false;
  String selectedLanguage = 'English';

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms and conditions'),
          content: const SingleChildScrollView(
            child: Text(
              '1. Account Terms\n'
              'Account Opening: By opening an account, you agree to provide accurate information and keep it up to date.\n'
              'Account Usage: Your account is for personal use unless explicitly stated. Unauthorized or illegal activities are strictly prohibited.\n'
              'Fees and Charges: Applicable fees for account maintenance, transactions, or other services will be outlined in the fee schedule.\n'
              'Account Closure: The bank reserves the right to close your account for inactivity, fraud, or violation of terms with prior notice.\n\n'
              '2. Transfers\n'
              'Internal Transfers: Transfers between accounts within the bank are processed instantly unless otherwise specified.\n'
              'External Transfers: Transfers to accounts outside the bank are subject to processing times, fees, and currency conversion rates.\n'
              'Limits: Daily and monthly transfer limits apply. These limits may vary based on your account type or verification status.\n'
              'Errors and Disputes: If you notice an error in a transfer, you must notify the bank within 30 days. The bank will investigate and resolve the issue per regulatory guidelines.\n'
              'Reversal Policy: The bank may reverse unauthorized or incorrect transactions upon investigation.',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://dashboard.codeparrot.ai/api/assets/Z43rOr9JV5SvYOp6'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white54, // Adjusted opacity for 20% more visibility
              BlendMode.lighten,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 88),
                const Text(
                  'Student',
                  style: TextStyle(
                    color: Color(0xFF0168AA),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 15),
                _buildNavigationItem(
                  'Student allowance form',
                  onTap: () {
                    context.push("/student_form");
                  },
                  showArrow: true,
                ),
                const Divider(color: Color(0xFFE8E8E8)),
                const SizedBox(height: 15),
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: Color(0xFF0168AA),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 15),
                _buildSwitchItem(
                  'Dark mode',
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() => isDarkMode = value);
                  },
                ),
                const Divider(color: Color(0xFFE8E8E8)),
                _buildSwitchItem(
                  'Biometric Login',
                  value: isBiometricEnabled,
                  onChanged: (value) {
                    setState(() => isBiometricEnabled = value);
                  },
                ),
                const Divider(color: Color(0xFFE8E8E8)),
                _buildNavigationItem(
                  'Income',
                  onTap: _showTermsAndConditions,
                  showArrow: true,
                ),
                const Divider(color: Color(0xFFE8E8E8)),
                _buildLanguageSelector(),
                const Divider(color: Color(0xFFE8E8E8)),
                _buildNavigationItem(
                  'Terms and conditions',
                  onTap: _showTermsAndConditions,
                  showArrow: true,
                ),
                const Divider(color: Color(0xFFE8E8E8)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          // Handle FAB click
        },
      ),
    );
  }

  Widget _buildSwitchItem(
    String title, {
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Language',
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: selectedLanguage,
              underline: const SizedBox(),
              items: ['English', 'Arabic'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedLanguage = newValue;
                  });
                }
              },
              style: const TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 16,
                fontFamily: 'Inter',
              ),
              dropdownColor: Colors.white,
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF1E1E1E)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(
    String title, {
    required VoidCallback onTap,
    bool showArrow = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            if (showArrow)
              Image.network(
                'https://dashboard.codeparrot.ai/api/assets/Z43pUXTr0Kgj1uYh',
                width: 24,
                height: 24,
              ),
          ],
        ),
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
            onPressed: () {},
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
