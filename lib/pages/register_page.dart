import 'package:chat_app_fire_base/components/my_button.dart';
import 'package:chat_app_fire_base/components/my_text_field.dart';
import 'package:chat_app_fire_base/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign up User
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            "Password do not match!",
            style: TextStyle(
              color: Color.fromRGBO(
                34,
                35,
                44,
                1,
              ),
            ),
          ),
        ),
      );
      return;
    }

    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
          emailController.text, passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Successfully registered",
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "You have been automatically logged in",
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
        const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            "Fill The data please!",
            style: TextStyle(
              color: Color.fromRGBO(
                34,
                35,
                44,
                1,
              ),
            ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: SingleChildScrollView(
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

                  //Create Account Message
                  const Text(
                    "Let's create an account for you!",
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
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //password text_field
                  MYTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //sing up button
                  MyButton(onTap: signUp, text: "Sign up"),

                  const SizedBox(
                    height: 50,
                  ),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already a member?",
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
                          "Login Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
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
