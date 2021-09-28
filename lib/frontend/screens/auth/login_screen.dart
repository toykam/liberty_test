import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/frontend/providers/auth_provider.dart';
import 'package:todo_app/utils/constants/colors.dart';
import 'package:todo_app/utils/constants/route_names.dart';
import 'package:todo_app/utils/constants/styles.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Sign in to Todo App", style: TextStyle(
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
              child: const Text("sign with email"),
              onPressed: () => authProvider.loginWithEmailAndPassword(
                context, email: emailController.text, password: passwordController.text
              ),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              child: const Text("sign in anonymously"),
              onPressed: () => authProvider.loginAnonymously(context),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              child: const Text("sign up"),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false),
            ),
          ],
        ),
      ),
    );
  }
}
