import 'package:flutter/material.dart';

class SetupBudgetPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController incomeController = TextEditingController();
  List<TextEditingController> budgetControllers = List.generate(6, (index) => TextEditingController());
  @override
    Widget build(BuildContext context) {
    var brightness = View.of(context).platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    // print(isDarkMode);
    Color titleTextColor = (isDarkMode) ? Colors.white : Colors.black;
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
                          createInput(title: "Monthly Income", hintText: "Income", controller: incomeController),
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
                          createInput(title: "Shopping", hintText: "Budget", controller: budgetControllers[0]),
                          createInput(title: "Online Shopping", hintText: "Budget", controller: budgetControllers[1]),
                          createInput(title: "Dining", hintText: "Budget", controller: budgetControllers[2]),
                          createInput(title: "Fuel", hintText: "Budget", controller: budgetControllers[3]),
                          createInput(title: "Super Market", hintText: "Budget", controller: budgetControllers[4]),
                          createInput(title: "Dining", hintText: "Budget", controller: budgetControllers[5]),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: ElevatedButton(
                              onPressed: () {
                                // if (!_formKey.currentState!.validate()) return;
                                // var output = {
                                //   'name': nameController.text,
                                //   'salary': incomeController.text,
                                //   'totalAmount': amountController.text,
                                //   'duration': selectedDuration,
                                //   'category': selectedCategory
                                // };
                                // print(output);
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