import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/frontend/providers/auth_provider.dart';
import 'package:todo_app/utils/constants/colors.dart';
import 'package:todo_app/utils/constants/route_names.dart';
import 'package:todo_app/utils/constants/styles.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Sign Up to Todo App", style: TextStyle(
            color: primaryColor
        ),),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 48,),
            TextFormField(
              controller: emailController,
              decoration: textFormFieldDecoration.copyWith(
                  hintText: 'Enter email'
              ),
            ),
            const SizedBox(height: 24,),
            TextFormField(
              controller: passwordController,
              decoration: textFormFieldDecoration.copyWith(
                  hintText: 'Enter password'
              ),
            ),
            const SizedBox(height: 48,),
            ElevatedButton(
              child: const Text("sign up with email"),
              onPressed: () => authProvider.signupWithEmailAndPassword(
                  context, email: emailController.text, password: passwordController.text
              ),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              child: const Text("sign in"),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false),
            ),
          ],
        ),
      ),
    );
  }
}
