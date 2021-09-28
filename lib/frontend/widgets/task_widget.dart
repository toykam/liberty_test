import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/backend/models/task.dart';
import 'package:todo_app/frontend/providers/task_list_provider.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskListProvider>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.fromLTRB(19.5, 29.5, 10, 28.5),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.9,
                child: Checkbox(
                  value: value.isTaskSelected(task), onChanged: (val) => value.selectTask(task),
                ),
              ),
              SizedBox(width: 11.5,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${task.title}', style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800
                    ),),
                    SizedBox(height: 4),
                    Text('${task.description}', style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF55565A).withOpacity(.6)
                    ),),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
