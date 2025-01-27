import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController(text: "username");
  final TextEditingController passwordController = TextEditingController(text: "password");

  SignInPage({super.key});
  final _formKey = GlobalKey<FormState>();
  String username = "username";
  String password = "password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Sign In',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   iconTheme: const IconThemeData(color: Colors.white),
      // ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(1, 104, 170, 1),
              Color.fromRGBO(102, 174, 220, 1),
            ],
            stops: [0.69, 0.93],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/image.png', width: 240, height: 252,),
                const SizedBox(height: 40),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon:
                        const Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) return "fill the blank";
                    return null;
                  },
                  onSaved: (newValue) {
                    username = newValue!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) return "fill the blank";
                    return null;
                  },
                  onSaved: (newValue) {
                    password = newValue!;
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // context.go('/signup');
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 200),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 12,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromRGBO(1, 104, 170, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () async {
                      // Sign in button logic
                      if (!_formKey.currentState!.validate()) return;
                      _formKey.currentState!.save();
                      var response = await context.read<AuthProvider>().signin(username: username, password: password);
                      print(response);
                      if (response['errors'] != null) {
                        for (var error in response['errors']) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error['message'])));
                        }
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sign in successfully")));
                        ScaffoldMessenger.of(context).clearSnackBars();
                        await context.read<AuthProvider>().initAuth();
                        GoRouter.of(context).go('/main');
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go('/register');
                      },
                      child: const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     context.go('/signup');
                    //   },
                    //   child: const Text(
                    //     'Sign in',
                    //     style: TextStyle(
                    //       color: Color.fromARGB(255, 0, 102, 255),
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
