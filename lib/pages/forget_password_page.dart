import 'package:chat_app_fire_base/components/my_button.dart';
import 'package:chat_app_fire_base/components/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(
        34,
        35,
        44,
        1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.mark_email_unread_outlined,
              color: Colors.white,
              size: 150,
            ),
            const SizedBox(
              height: 30,
            ),
            MYTextField(
              controller: _emailController,
              hintText: "Email",
              obscureText: false,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              onTap: () => emailVerification(),
              text: "Send Email",
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Are you lost here?",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                "Back to login Screen",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void emailVerification() async {
    if (_emailController.text.isNotEmpty) {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Email Sent Successfully",
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
      Navigator.pop(context);
    }
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            "Fill The Email Please",
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
}
