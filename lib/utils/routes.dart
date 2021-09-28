
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/frontend/providers/create_task_provider.dart';
import 'package:todo_app/frontend/screens/auth/login_screen.dart';
import 'package:todo_app/frontend/screens/auth/register.dart';
import 'package:todo_app/frontend/screens/auth_wrapper_screen.dart';
import 'package:todo_app/frontend/screens/task/create_task.dart';
import 'package:todo_app/frontend/screens/task/all_tasks.dart';
import 'package:todo_app/utils/constants/route_names.dart';

class RouteGenerator {

  static Route onGenerateRoute(RouteSettings settings) {
    String name = settings.name!;

    switch (name) {
      case initialRoute:
        return _buildRoute(const AuthWrapperScreen());
      case allTaskListRoute:
        return _buildRoute(const AllTaskScreen());
      case createTaskRoute:
        return _buildRoute(ChangeNotifierProvider(
          child: const CreateTaskScreen(),
          create: (context) => CreateTaskProvider(),
        ));
      case loginRoute:
        return _buildRoute(LoginScreen());
      case registerRoute:
        return _buildRoute(RegisterScreen());
      default:
        return _buildRoute(Container());
    }
  }

  static Route _buildRoute(Widget child) {
    return MaterialPageRoute(builder: (context) => child,);
  }
}

