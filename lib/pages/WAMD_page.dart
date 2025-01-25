import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/AccountDropdown.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

final _formKey = GlobalKey<FormState>();

class WamdPage extends StatelessWidget {

  final TextEditingController numberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final dropdown = AccountDropdown();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 238, 238, 1),
      body: Stack(
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover
              )
            ),
            child: SizedBox(width: double.maxFinite, height: double.maxFinite,)
          ),
          SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const SizedBox(height: 100,),
                AppBar(forceMaterialTransparency: true,),
                // Heading for Goals
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    "WAMD",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(1, 104, 170, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 30,),
                        dropdown,
                        createPhoneNumberForm(title: "Phone Number", input: "number", controller: numberController),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              // elevation: 12,
                              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                              backgroundColor: const Color.fromRGBO(1, 104, 170, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),  
                            child: const Text("Verify", style: TextStyle(color: Colors.white, fontSize: 16),)
                          ),
                        ),
                        createAmountInput(title: "Amount", hintText: "amount", controller: amountController),
                        const SizedBox(height: 30,),
                        FormField(
                          // forceErrorText: "please check the box",
                          initialValue: false,
                          builder: (FormFieldState<bool> state) { 
                            return CheckboxListTile(
                              activeColor: const Color.fromRGBO(1, 104, 170, 1),
                              dense: state.hasError,
                              title: const Row(
                                children: [
                                  Text('Agree to ', style: TextStyle(fontSize: 16),),
                                  Text('Terms & Conditions above', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
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
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;
                              var output = {
                                'phone number': numberController.text,
                                'amount': amountController.text,
                              };
                              print(output);
                              await showDialog(
                                context: context,
                                barrierDismissible: false, 
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: const Text('Success', style: TextStyle(fontSize: 30),),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Lottie.network(
                                          'https://assets10.lottiefiles.com/packages/lf20_xlkxtmul.json',
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.cover,
                                          repeat: false,
                                        ),
                                        // Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            // elevation: 12,
                                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                            backgroundColor: const Color.fromRGBO(1, 104, 170, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ),  
                                          child: const Text("Dismiss", style: TextStyle(color: Colors.white, fontSize: 16),)
                                        ),
                                      )
                                    ],
                                  );
                                }
                              );
                              context.pop();
                            },
                            style: ElevatedButton.styleFrom(
                              // elevation: 12,
                              padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                              backgroundColor: const Color.fromRGBO(1, 104, 170, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ), 
                            child: const Text("Send", style: TextStyle(color: Colors.white, fontSize: 16),)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
            ),
          )
        ]
      ),
    );
  }
}

Widget createAmountInput({required String title, required String hintText, required TextEditingController controller}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          ],
        ),
        const SizedBox(height: 10,),
        TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            suffixIcon: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text('KWD', style: TextStyle(fontSize: 16, color: Colors.black),)
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromRGBO(223, 222, 222, 1)),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(16.0),
            ),
            hintText: hintText,
          ),
          validator: (value) {
            if (value!.isEmpty) return "fill the blank";
            return null;
          },
          // onSaved: (newValue) {
          //   password = newValue!;
          // },
        )
      ],
    ),
  );
}

Widget createPhoneNumberForm({required String title, required String input, required TextEditingController controller}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          ],
        ),
        const SizedBox(height: 10,),
        TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIcon: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text('+965', style: TextStyle(fontSize: 16, color: Colors.grey),)
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromRGBO(223, 222, 222, 1)),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(16.0),
            ),
            hintText: input,
          ),
          validator: (value) {
            if (value!.isEmpty) return "fill the blank";
            return null;
          },
          // onSaved: (newValue) {
          //   password = newValue!;
          // },
        )
      ],
    ),
  );
}