import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StepsPage(),
  ));
}

List<Widget> forms = [
  createInfo(),
  createForm(
    title: 'What\'s your name?',
    subtitle: 'Tell us your prefered name',
    input: 'Name'
  ),
  createPhoneNumberForm(
    title: 'What’s your phone number?',
    subtitle: 'We’ll send you an OTP code to verify it',
    input: 'XXXXXXXX'
  ),
  createForm(
    title: 'What\'s your email address?',
    subtitle: 'We’ll send you an OTP code to verify it',
    input: 'Email'
  ),
  createOTP(),
  createForm(
    title: 'Enter Civil ID number',
    subtitle: 'We’ll send a request in Kuwait Mobile ID \nPlease Approve it ',
    input: 'Civil ID Number'
  ),
  createPasswordForm(),
  createComplete()
];

final _formKey = GlobalKey<FormState>();
final TextEditingController inputController = TextEditingController();

List<String> info = [];

class StepsPage extends StatefulWidget{
  const StepsPage({super.key});

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B69C7),
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {}, 
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
              forms[index],
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
                              if (index == forms.length-1) GoRouter.of(context).go('/home');
                              if (!_formKey.currentState!.validate()) return;
                              _formKey.currentState!.save();
                              inputController.clear();
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
                                  'nickname': info[0],
                                  'phone': info[1],
                                  'email': info[2],
                                  'civilID': info[3],
                                  'password': info[4]
                                };
                                print(submitedInfo);
                              }
                            
                                if (index < forms.length-1) {
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


Widget createForm({required String title, required String subtitle, required String input}) {
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
        Form(
          key: _formKey,
          child: TextFormField(
            controller: inputController,
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
        ),
      ],
    ),
  );
}

Widget createInfo() {
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
        Form(
          key: _formKey,
          child: FormField(
            // forceErrorText: "please check the box",
            initialValue: false,
            builder: (FormFieldState<bool> state) { 
              return CheckboxListTile(
                dense: state.hasError,
                title: const Row(
                  children: [
                    Text('Agree to ', style: TextStyle(fontSize: 16),),
                    Text('Terms & Conditions above', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
          )
        ),
      ],
    ),
  );
}

Widget createPhoneNumberForm({required String title, required String subtitle, required String input}) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
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
        Form(
          key: _formKey,
          child: TextFormField(
            controller: inputController,
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
        ),
      ],
    ),
  );
}

Widget createOTP() {
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
        Form(
          key: _formKey,
          child: TextFormField(
            controller: inputController,
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
        ),
        const SizedBox(height: 16),
        const Text(
          'Time left: 1:00',
          style: TextStyle(
            fontSize: 16,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget createPasswordForm() {
  final TextEditingController passwordController = TextEditingController();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
    child: Form(
      key: _formKey,
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
            controller: inputController,
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