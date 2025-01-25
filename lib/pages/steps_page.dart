import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StepsPage(),
  ));
}

final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController otpController = TextEditingController();
final TextEditingController civilController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();

List<Widget> forms(BuildContext context) => [
  createInfo(context),
  createForm(
    title: 'What\'s your name?',
    subtitle: 'Tell us your prefered name',
    input: 'Name',
    controller: nameController
  ),
  createPhoneNumberForm(
    title: 'What’s your phone number?',
    subtitle: 'We’ll send you an OTP code to verify it',
    input: 'XXXXXXXX',
  ),
  createForm(
    title: 'What\'s your email address?',
    subtitle: 'We’ll send you an OTP code to verify it',
    input: 'Email',
    controller: emailController
  ),
  createOTP(),
  createForm(
    title: 'Enter Civil ID number',
    subtitle: 'We’ll send a request in Kuwait Mobile ID \nPlease Approve it ',
    input: 'Civil ID Number',
    controller: civilController
  ),
  createPasswordForm(),
  createComplete()
];

List<String> info = [];

class StepsPage extends StatefulWidget{
  const StepsPage({super.key});

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> with SingleTickerProviderStateMixin {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color(0xFF2B69C7),
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              if (index > 0) {
                index--;
              } else {
                context.pop();
              }
            });
          }, 
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        centerTitle: true,
        title: Image.asset('assets/images/mini_logo.png', width: 83, height: 79,),
        toolbarHeight: 100,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LinearProgressBar(
            minHeight: 5,
            backgroundColor: Colors.transparent,
            progressColor: Colors.black,
            maxSteps: 7,
            progressType: LinearProgressBar.progressTypeLinear,
            currentStep: index,
          ),
          const SizedBox(height: 10,),
          Container(
            width: double.infinity,
            height: 750,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Stack(
              children: [
              AnimatedSwitcher(
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                duration: const Duration(milliseconds: 500),
                child: Container(
                  key: ValueKey(index),
                  child: Form(
                    key: formKey,
                    child: forms(context)[index]
                  ),
                )
              ),
              // createOTP(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                        padding: const EdgeInsets.only(bottom: 150, left: 30, right: 30),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (index == forms(context).length-1) GoRouter.of(context).go('/home');
                              if (!formKey.currentState!.validate()) return;
                              formKey.currentState!.save();
                              // inputController.clear();
                              if (index == 5) {
                                await showDialog(
                                  context: context,
                                  // barrierDismissible: false, 
                                  builder: (BuildContext context) {
                                    return SimpleDialog(
                                      title: const Text("Waiting for Approval", style: TextStyle(fontSize: 30),),
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: const CircularProgressIndicator(),
                                        )
                                      ],
                                    );
                                  }
                                );
                              }
                              else if (index == 6) {
                                await showDialog(
                                  context: context,
                                  // barrierDismissible: false, 
                                  builder: (BuildContext context) {
                                    return SimpleDialog(
                                      title: const Text('Creating the account', style: TextStyle(fontSize: 30),),
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: const CircularProgressIndicator(),
                                        )
                                      ],
                                    );
                                  }
                                );
                                Map<String, dynamic> submitedInfo = {
                                  'username': info[0],
                                  'phoneNumber': info[1],
                                  'password': info[4],
                                  'email': info[2],
                                  // 'civilID': info[3],
                                };
                                print(submitedInfo);

                                var response = await context.read<AuthProvider>().signup(submitedInfo);
                                print(response);
                                if (response['error'] != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['error']!)));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sign up successfully")));
                                }
                              }

                              if (index < forms(context).length-1) {
                                setState(() {
                                  index++;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2B69C7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


Widget createForm({required String title, required String subtitle, required String input, required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,  //title  'What\'s your name?'
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,  //'Tell us your prefered name'
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: input,  //'Name'
            // filled: true,
            // fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) return "fill the blank";
            return null;
          },
          onSaved: (newValue) {
            info.add(newValue!);
            // print(newValue);
          },
        ),
      ],
    ),
  );
}

void _showTermsAndConditions(BuildContext context) {
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

Widget createInfo(BuildContext context) {
  bool v = false;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Before we start',  //title  'What\'s your name?'
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Please confirm the following:',  //'Tell us your prefered name'
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 50),
        const Text('I am a resident of Kuwait and have a valid Civil ID', style: TextStyle(fontSize: 16),),
        const Divider(),
        const Text('I not politically exposed person', style: TextStyle(fontSize: 16),),
        const SizedBox(height: 300,),
        FormField(
          // forceErrorText: "please check the box",
          initialValue: false,
          builder: (FormFieldState<bool> state) { 
            return CheckboxListTile(
              dense: state.hasError,
              title: Row(
                children: [
                  const Text('Agree to ', style: TextStyle(fontSize: 16),),
                  GestureDetector(
                    onTap: () {
                      _showTermsAndConditions(context);
                    },
                    child: const Text(
                      'Terms & Conditions above', 
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ],
              ),
              value: state.value,
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText ?? "",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
          validator: (value) {
            if (value != true) return("please check the box");
            return null;
          },
        ),
      ],
    ),
  );
}

Widget createPhoneNumberForm({required String title, required String subtitle, required String input}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,  //title  'What\'s your name?'
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,  //'Tell us your prefered name'
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
            hintText: input,
            // filled: true,
            // fillColor: Colors.grey,
            prefixIcon: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text('+965', style: TextStyle(fontSize: 16, color: Colors.grey),)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) return "fill the blank";
            return null;
          },
          onSaved: (newValue) {
            info.add(newValue!);
            // print(newValue);
          },
        ),
      ],
    ),
  );
}

Widget createOTP() {
  int start = 100;
  return Container(
    padding: const EdgeInsets.all(24.0),
    margin: const EdgeInsets.only(top: 150),
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Type the OTP',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: otpController,
          decoration: InputDecoration(
            hintText: 'OTP',
            // filled: true,
            // fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) return "fill the blank";
            return null;
          },
          onSaved: (newValue) {
            // username = newValue!;
          },
        ),
        const SizedBox(height: 16),
        const Text(
          'Time limit is 5 minutes',
          style: TextStyle(
            fontSize: 16,
            // fontWeight: FontWeight.bold,
          ),
        ),
        // StatefulBuilder(
        //   builder: (context, setState) {
        //     Timer _timer;
        //     _timer = Timer.periodic(
        //       const Duration(seconds: 1), 
        //       (Timer timer) {
        //         if (start == 0) {
        //           setState(() {
        //             timer.cancel();
        //           }
        //           );
        //         }
        //         else {
        //           setState(() {
        //             // print(start);
        //             start--;
        //           });
        //         }
        //       }
        //     );
        //     return Text(
        //       'Time left: $start',
        //       style: const TextStyle(
        //         fontSize: 16,
        //         // fontWeight: FontWeight.bold,
        //       ),
        //     );
        //   }
        // ),
      ],
    ),
  );
}

Widget createPasswordForm() {
  final TextEditingController passwordController = TextEditingController();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set a password',  //title  'What\'s your name?'
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            // filled: true,
            // fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) return "fill the blank";
            return null;
          },
          onSaved: (newValue) {
            // username = newValue!;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: confirmPasswordController,
          decoration: InputDecoration(
            hintText: 'Confirm password',  //'Name'
            // filled: true,
            // fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) return "fill the blank";
            else if (value != passwordController.text) return "Password does not match";
            return null;
          },
          onSaved: (newValue) {
            // username = newValue!;
            info.add(newValue!);
          },
        ),
      ],
    ),
  );
}

Widget createComplete() {
  return const Center(
    child: 
      Column(
        children: [
          SizedBox(height: 150,),
          Icon(Icons.check_circle_outline_rounded, size: 200, color: Colors.green,),
          SizedBox(height: 16,),
          Text(
            'Complete',  //title  'What\'s your name?'
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
  );
}