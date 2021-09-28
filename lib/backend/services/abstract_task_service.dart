import 'package:todo_app/backend/models/task.dart';
import 'package:todo_app/backend/models/user.dart';

abstract class AbstractTaskService {

  // Get All Task By User
  Future<List<Task>?> getTasksByUser(User  user);
  // Create Task
  Future<bool> createTask(Task task);
  // Get A Task

  // Delete Tasks
  Future<bool> deleteTasks(List<String> taskIds);
}