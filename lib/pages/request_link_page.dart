import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/AccountDropdown.dart';
import 'package:go_router/go_router.dart';

final _formKey = GlobalKey<FormState>();

class RequestLinkPage extends StatelessWidget {
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();

  final dropdown = AccountDropdown();

  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 238, 238, 1),
      body: Stack(
        children: [
          const DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover
              )
            ),
            child: const SizedBox(width: double.maxFinite, height: double.maxFinite,)
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
                    "Request Link",
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
                        createInput(title: "Payer Name", hintText: "name", controller: nameController),
                        createAmountInput(title: "Amount", hintText: "amount", controller: amountController),
                        createPhoneNumberForm(title: "Phone Number", input: "number", controller: numberController),
                        createPurposeInput(title: "Link Purpose", hintText: "Select", controller: purposeController),
                        const SizedBox(height: 30,),
                        FormField(
                          // forceErrorText: "please check the box",
                          initialValue: false,
                          builder: (FormFieldState<bool> state) { 
                            return CheckboxListTile(
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
                                'name': nameController.text,
                                'amount': amountController.text,
                                'phone number': numberController.text,
                                'purpose': purposeController.text
                              };
                              print(output);
                              await showDialog(
                                context: context,
                                barrierDismissible: false, 
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: const Text('Success', style: TextStyle(fontSize: 30),),
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.check_circle_outline, size: 100, color: Colors.green,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                                        child:
                                        StatefulBuilder(
                                          builder: (BuildContext context, setState) {
                                            return GestureDetector(
                                              onTap: () {
                                                // print(clicked);
                                                setState(() {
                                                  clicked = true;
                                                }
                                                );
                                              },
                                              child: (!clicked) ? const Text(
                                                "Copy Link", 
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(1, 104, 170, 1), 
                                                  decoration: TextDecoration.underline
                                                ),
                                              ) 
                                              // ignore: dead_code
                                              : const Text(
                                                "Link Copied", 
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black, 
                                                  decoration: TextDecoration.underline
                                                ),
                                              ) 
                                            );
                                          }
                                        ),
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

Widget createInput({required String title, required String hintText, required TextEditingController controller}) {
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

Widget createPurposeInput({required String title, required String hintText, required TextEditingController controller}) {
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
        DropdownButtonFormField(
          hint: const Text("Select"),
          decoration: InputDecoration(
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
          items: const  [
            DropdownMenuItem(
              value: "first",
              child: Text("first")
            ),
            DropdownMenuItem(
              value: "seconds",
              child: Text("seconds")
            ),
            DropdownMenuItem(
              value: "third",
              child: Text("third")
            )
          ], 
          onChanged: (newValue) {
            controller.text = newValue!;
          },
          validator: (value) {
            if (value == null) return "fill the blank";
            return null;
          },
        ),
      ],
    ),
  );
}