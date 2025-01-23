import 'package:flutter/material.dart';
import 'package:frontend/widgets/AccountDropdown.dart';
import 'package:frontend/widgets/TabSwitcher.dart';
import 'package:go_router/go_router.dart';

class TransferPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController beneficiaryController = TextEditingController();

  final SwitchModel notifier = SwitchModel();
  final dropdown = AccountDropdown();

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
                    "Transfer",
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
                        TabSwitcher(switchModel: notifier,),
                        const SizedBox(height: 30,),
                        dropdown,
                        createInput(title: "IBAN", hintText: "Iban", controller: ibanController),
                        createInput(title: "Amount", hintText: "amount", controller: amountController),
                        ListenableBuilder(
                          listenable: notifier, 
                          builder: (BuildContext context, Widget? child) {
                            if (!notifier.isLocal) {
                              return Column(
                                children: [
                                  createInput(title: "Address", hintText: "address", controller: addressController),
                                  createInput(title: "Beneficiary Name", hintText: "name", controller: beneficiaryController),
                                ],
                              );
                            }
                            else {
                              return const SizedBox();
                            }
                          }
                        ),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;
                              Map<String, dynamic> output = {
                                'iban': ibanController.text,
                                'amount': amountController.text
                              };
                              if (!notifier.isLocal) {
                                output['address'] = addressController.text;
                                output['beneficiary'] = beneficiaryController.text;
                              }
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
                                        child: Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
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