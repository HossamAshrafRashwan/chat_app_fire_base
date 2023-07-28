import 'package:chat_app_fire_base/components/my_button.dart';
import 'package:chat_app_fire_base/components/my_text_field.dart';
import 'package:chat_app_fire_base/pages/forget_password_page.dart';
import 'package:chat_app_fire_base/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sing in User
  void signIn() async {
    // get the auth services
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
        emailController.text,
        passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Successfully Logged in",
            style: TextStyle(
              color: Color.fromRGBO(
                34,
                35,
                44,
                1,
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 35, 44, 1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  //Logo
                  const Icon(
                    Icons.message,
                    size: 100,
                    color: Colors.green,
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  //Welcome Back message
                  const Text(
                    "Welcome Back you 've been missed",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // email text field
                  MYTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //password text_field
                  MYTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //sing in button
                  MyButton(onTap: signIn, text: "sing in"),

                  const SizedBox(
                    height: 50,
                  ),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Not a member?",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordPage(),
                      ),
                    ),
                    child: const Text(
                      "Forget Password",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
