import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/backend/models/user.dart';
import 'package:todo_app/backend/services/implementation/index.dart';
import 'package:todo_app/frontend/providers/auth_provider.dart';
import 'package:todo_app/frontend/screens/auth/login_screen.dart';
import 'package:todo_app/frontend/screens/task/all_tasks.dart';
import 'package:todo_app/utils/constants/route_names.dart';

class AuthWrapperScreen extends StatefulWidget {
  const AuthWrapperScreen({Key? key}) : super(key: key);

  @override
  State<AuthWrapperScreen> createState() => _AuthWrapperScreenState();
}

class _AuthWrapperScreenState extends State<AuthWrapperScreen> {

  navigateToNextScreen() async {
    User? user = await auth.getCurrentUser();
    if (user == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(allTaskListRoute, (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Please wait...'),
      ),
    );
  }
}
