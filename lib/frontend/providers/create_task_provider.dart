
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/backend/models/task.dart';
import 'package:todo_app/backend/models/user.dart';
import 'package:todo_app/backend/services/implementation/index.dart';
import 'package:todo_app/frontend/providers/task_list_provider.dart';
import 'package:uuid/uuid.dart';


class CreateTaskProvider extends ChangeNotifier {

  final Task task = Task();

  set setTaskDate(DateTime date) {
    task.dueDate = date.toString();
    notifyListeners();
  }

  CreateTaskProvider() {
    final uuid = Uuid();
    task.dueDate = DateTime.now().toString();
    task.id = uuid.v4();
  }

  void createTask(BuildContext context) async {
    BotToast.showLoading();

    User? user = await auth.getCurrentUser();
    task.uid = user!.uid;
    try {
      await taskService.createTask(task);
      BotToast.showSimpleNotification(title: 'Task created successfully');

      BotToast.closeAllLoading();
      Provider.of<TaskListProvider>(context, listen: false).initialize();
      Navigator.pop(context);
    } catch (error) {
      BotToast.showSimpleNotification(title: 'Error: ${error}', backgroundColor: Colors.red);
      BotToast.closeAllLoading();
    }
  }
}