import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

  void _showPrompt(BuildContext con) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set your Income'),
          content: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Income"
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await Provider.of<AuthProvider>(con, listen: false).setIncome(int.parse(controller.text));
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
            image: AssetImage('assets/images/background.png'),
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
                  onTap: () {
                    _showPrompt(context);
                  },
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
                InkWell(
                  onTap: () {
                    context.read<AuthProvider>().logout();
                    context.go('/signin');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign out",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const Divider(color: Color(0xFFE8E8E8)),
              ],
            ),
          ),
        ),
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
              const Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}
