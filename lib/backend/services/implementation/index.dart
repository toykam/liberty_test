import 'package:todo_app/backend/services/abstract_task_service.dart';
import 'package:todo_app/backend/services/implementation/firebase/task_service.dart';

import '../auth.dart';
import 'firebase/firebase_auth.dart';

final AbstractAuthentication auth = FirebaseAuthentication();
final AbstractTaskService taskService = FirebaseTaskService();