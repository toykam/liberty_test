

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/backend/models/task.dart';
import 'package:todo_app/backend/models/user.dart';
import 'package:todo_app/backend/services/implementation/index.dart';

class TaskListProvider extends ChangeNotifier {
  List<Task> userTasks = [];

  List<String> selectedTasks = [];


  TaskListProvider() {
    initialize();
  }

  void initialize() async {
    User? user = await auth.getCurrentUser();
    userTasks = (await taskService.getTasksByUser(user!))!;
    notifyListeners();
  }

  void selectTask(Task task) {
    if (!isTaskSelected(task)) {
      selectedTasks.add(task.id!);
    } else {
      selectedTasks.remove(task.id);
    }
    notifyListeners();
  }

  void selectAll() {
    if (userTasks.length == selectedTasks.length) {
      selectedTasks = [];
    } else {
      selectedTasks = userTasks.map((e) => e.id!).toList();
    }
    notifyListeners();
  }

  bool isTaskSelected(Task task) {
    return selectedTasks.contains(task.id);
  }

  void deleteTasks() async {
    BotToast.showLoading();
    print(selectedTasks);
    try {
      await taskService.deleteTasks(selectedTasks);
      selectedTasks = [];
      initialize();
      BotToast.closeAllLoading();
    } catch (error) {
      BotToast.closeAllLoading();
      BotToast.showSimpleNotification(title: 'Error: $error');
    }
  }

  void confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Do you want to delete selected tasks?'),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () => deleteTasks(),
            ),
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}