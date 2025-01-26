import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/budget_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SetupBudgetPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController incomeController = TextEditingController();
  List<TextEditingController> budgetControllers = List.generate(6, (index) => TextEditingController());

  SetupBudgetPage({super.key});
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 238, 238, 1),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const SizedBox(height: 100,),
                  AppBar(
                    forceMaterialTransparency: true,
                    title: const Text(
                          "Setup Budget",
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
                          FutureBuilder(
                            future: context.read<AuthProvider>().getIncome(),
                            builder: (context, dataSnapshot) {
                              return Consumer<AuthProvider>(
                                builder: (context, provider, _) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 15),
                                    child: Row(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Based on your Monthly Income: ${provider.income} KWD", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                        const SizedBox(height: 10,),
                                      ],
                                    ),
                                  );
                                }
                              );
                            }
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Choose your categories, and set a budget", 
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ),
                          createInput(title: "Online Shopping", hintText: "Budget", controller: budgetControllers[0]),
                          createInput(title: "Restaurant", hintText: "Budget", controller: budgetControllers[1]),
                          createInput(title: "Fuel", hintText: "Budget", controller: budgetControllers[2]),
                          createInput(title: "Entertainment", hintText: "Budget", controller: budgetControllers[3]),
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) return;
                                var output = {
                                  'Online Shopping': int.parse(budgetControllers[0].text),
                                  'Restaurant': int.parse(budgetControllers[1].text),
                                  'Fuel': int.parse(budgetControllers[2].text),
                                  'Entertainment': int.parse(budgetControllers[3].text),
                                };
                                // print(output);
                                var response = await context.read<BudgetProvider>().setBudget(output);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['message'])));
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
                              child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16),)
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
              ),
            ),
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
            const Icon(Icons.check_box_outlined),
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