

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/backend/models/task.dart';
import 'package:todo_app/backend/models/user.dart';
import 'package:todo_app/backend/services/abstract_task_service.dart';

class FirebaseTaskService implements AbstractTaskService {
  final CollectionReference _taskCollection = FirebaseFirestore.instance.collection('tasks');

  @override
  Future<bool> createTask(Task task) async {
    try {
      await _taskCollection.add(task.toJson());
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<List<Task>?> getTasksByUser(User user) async{
    try {
      print("USERID: ${user.uid}");
      return _taskCollection.where('uid', isEqualTo: user.uid).get().then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return Task(
            title: doc['title'],
            uid: doc['uid'],
            description: doc['description'],
            dueDate: doc['dueDate'],
            id: doc.reference.id,
          );
        }).toList();
      });
    } catch (error) {
      return null;
    }
  }

  @override
  Future<bool> deleteTasks(List<String> taskIds) async {
    try {
      taskIds.forEach((element) {
        _taskCollection.doc(element).delete();
      });
      return true;
    } catch (error) {
      return false;
    }
  }
}