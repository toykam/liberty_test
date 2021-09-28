import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/backend/models/user.dart';
import 'package:todo_app/backend/services/implementation/index.dart';
import 'package:todo_app/frontend/providers/task_list_provider.dart';
import 'package:todo_app/utils/constants/route_names.dart';

class AuthProvider extends ChangeNotifier {
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  AuthProvider() {
    initialize();
  }

  set setLoggedIn(bool loggedIn)  {
    _loggedIn = loggedIn;
    notifyListeners();
  }

  void initialize() async {
    try {

    } catch (error) {

    }
  }

  void logout(BuildContext ctx) async {
    bool loggedOut = await auth.signOut();
    if (loggedOut) {
      setLoggedIn = false;
      Navigator.of(ctx).pushNamedAndRemoveUntil(initialRoute, (route) => false);
    }
  }

  void loginAnonymously(BuildContext ctx) async {
    BotToast.showLoading();
    User? user = await auth.signInAnonymously();
    if (user != null) {
      BotToast.showSimpleNotification(title: 'Login successful');
      setLoggedIn = true;
      Provider.of<TaskListProvider>(ctx, listen: false).initialize();
      Navigator.of(ctx).pushNamedAndRemoveUntil(allTaskListRoute, (route) => false);
    } else {
      BotToast.showSimpleNotification(title: 'Login failed, please try again');
    }
    BotToast.closeAllLoading();
  }

  void loginWithEmailAndPassword(BuildContext ctx, {required String email, required String password}) async {
    BotToast.showLoading();
    User? user = await auth.signInWthEmailAndPassword(email, password);
    if (user != null) {
      BotToast.showSimpleNotification(title: 'Login successful');
      setLoggedIn = true;
      Provider.of<TaskListProvider>(ctx, listen: false).initialize();
      Navigator.of(ctx).pushNamedAndRemoveUntil(allTaskListRoute, (route) => false);
    } else {
      BotToast.showSimpleNotification(title: 'Login failed, please try again');
    }
    BotToast.closeAllLoading();
  }

  void signupWithEmailAndPassword(BuildContext ctx, {required String email, required String password}) async {
    BotToast.showLoading();
    User? user = await auth.signUpWthEmailAndPassword(email, password);
    if (user != null) {
      BotToast.showSimpleNotification(title: 'Registration successful, you can now login', backgroundColor: Colors.green);
      setLoggedIn = true;
      Navigator.of(ctx).pushNamedAndRemoveUntil(loginRoute, (route) => false);
    } else {
      BotToast.showSimpleNotification(title: 'Login failed, please try again');
    }
    BotToast.closeAllLoading();
  }
}