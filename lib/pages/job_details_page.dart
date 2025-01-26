import 'package:flutter/material.dart';

class JobDetailsPage extends StatelessWidget {

  JobDetailsPage({super.key});

  Map<String, double> dataMap = {
    "Online Shopping": 3,
    "Dining": 3,
    "Fuel": 3,
    "Entertainment": 2,
  };

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  
  @override
    Widget build(BuildContext context) {
    // var brightness = View.of(context).platformDispatcher.platformBrightness;
    // bool isDarkMode = brightness == Brightness.dark;
    // // print(isDarkMode);
    // Color titleTextColor = (isDarkMode) ? Colors.white : Colors.black;
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
                          "Burgan HQ",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(1, 104, 170, 1),
                          ),
                        ),
                    // actions: [
                    //   IconButton(onPressed: () => context.push('/setupBudget'), icon: const Icon(Icons.edit))
                    // ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.all(50),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Image.asset(
                            'assets/images/burgan-bank-logo.png',
                            height: 200,
                            width: 200,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Card(
                          elevation: 5,
                          child: Container(
                            // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Description:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                SizedBox(height: 100,)
                              ],
                            )
                          ),
                        ),
                        const SizedBox(height: 10,),
                        createInput(title: "Name", hintText: "name", controller: nameController),
                        createPhoneNumberForm(title: "PhoneNumber", subtitle: "XXXXXXX", input: "XXXXXXX", controller: phoneController),
                        const Row(
                          children: [
                            const Text(
                              "Resume",  //title  'What\'s your name?'
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12.0),
                            ), 
                          ),
                          onPressed: () {}, 
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Upload Resume", style: TextStyle(color: Colors.black),),
                                Icon(Icons.upload, color: Colors.black,)
                              ],
                            ),
                          )
                        ),
                        const SizedBox(height: 50,),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () {
                              
                            },
                            style: ElevatedButton.styleFrom(
                              // elevation: 12,
                              padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                              backgroundColor: const Color.fromRGBO(1, 104, 170, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ), 
                            child: const Text("Apply", style: TextStyle(color: Colors.white, fontSize: 16),)
                          ),
                        ),
                      ],
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

Widget createInput({required String title, required String hintText, required TextEditingController controller, bool readOnly = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        const SizedBox(height: 10,),
        TextFormField(
          readOnly: readOnly,
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

Widget createPhoneNumberForm({required String title, required String subtitle, required String input, required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,  //title  'What\'s your name?'
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: 
          // InputDecoration(
          //   hintText: input,
          //   // filled: true,
          //   // fillColor: Colors.grey,
          //   prefixIcon: Container(
          //     padding: const EdgeInsets.all(16.0),
          //     child: const Text('+965', style: TextStyle(fontSize: 16, color: Colors.grey),)
          //   ),
          //   border: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.grey.shade100),
          //     borderRadius: BorderRadius.circular(12.0),
          //   ),
          // ),
          InputDecoration(
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
            // hintText: hintText,
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) return "fill the blank";
            return null;
          },
          onSaved: (newValue) {
            // info.add(newValue!);
            // print(newValue);
          },
        ),
      ],
    ),
  );
}