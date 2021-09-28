import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/backend/models/task.dart';
import 'package:todo_app/backend/services/implementation/index.dart';
import 'package:todo_app/frontend/providers/auth_provider.dart';
import 'package:todo_app/frontend/providers/task_list_provider.dart';
import 'package:todo_app/frontend/widgets/task_widget.dart';
import 'package:todo_app/utils/constants/colors.dart';
import 'package:todo_app/utils/constants/route_names.dart';

class AllTaskScreen extends StatelessWidget {
  const AllTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: Transform.rotate(
          child: const Icon(Icons.hourglass_empty_rounded, size: 33, color: primaryColor,),
          angle: 310,
        ),
        actions: [
          Consumer<TaskListProvider>(
            builder: (context, value, child) {
              return IconButton(
                onPressed: value.selectedTasks.isEmpty ? null : () =>  value.confirmDelete(context),
                icon: Icon(Icons.delete, color: value.selectedTasks.isNotEmpty ? Colors.black : Colors.grey,)
              );
            },
          ),
          IconButton(onPressed: () => authProvider.logout(context), icon: const Icon(Icons.logout_rounded, color: primaryColor,)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<TaskListProvider>(
                  builder: (context, value, child) {
                    if (value.selectedTasks.isEmpty) {
                      return Container(height: 65,);
                    }
                    return Column(
                      children: [
                        Transform.scale(
                          scale: 1.7,
                          child: Checkbox(
                            value: value.userTasks.length == value.selectedTasks.length,
                            onChanged: (val) => value.selectAll(), activeColor: Colors.white,
                            checkColor: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 1.5,),
                        const Text('Mark all', style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white
                        ),)
                      ],
                    );
                  },
                )
              ],
            ),
            const Text('28th May, 2021', style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400
            ),),
            const SizedBox(height: 8,),
            Expanded(
              child: Consumer<TaskListProvider>(
                builder: (context, value, child) => ListView.builder(
                  itemCount: value.userTasks.length,
                  itemBuilder: (context, index) {
                    Task task = value.userTasks[index];
                    return TaskWidget(task: task,);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: color2, size: 37,),
        onPressed: () => Navigator.of(context).pushNamed(createTaskRoute),
        backgroundColor: Colors.white,
      ),
    );
  }
}
