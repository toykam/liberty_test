import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/frontend/providers/auth_provider.dart';
import 'package:todo_app/frontend/providers/create_task_provider.dart';
import 'package:todo_app/utils/constants/colors.dart';
import 'package:todo_app/utils/constants/styles.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final createTaskProvider = Provider.of<CreateTaskProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor,),
          onPressed: () =>Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        title: const Text('Add Task', style: TextStyle(
          color: primaryColor
        ),),
        actions: [
          IconButton(onPressed: () => authProvider.logout(context), icon: const Icon(Icons.logout_rounded, color: primaryColor,)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 48,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("What is to be done?", style: formLabelStyle,),
                  SizedBox(height: 3,),
                  TextFormField(
                    decoration: textFormFieldDecoration.copyWith(
                      hintText: 'Title'
                    ),
                    onChanged: (value) => createTaskProvider.task.title = value,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description of task", style: formLabelStyle,),
                  SizedBox(height: 3,),
                  TextFormField(
                    decoration: textFormFieldDecoration.copyWith(
                      hintText: ''
                    ),
                    onChanged: (value) => createTaskProvider.task.description = value,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text("Due Date", style: formLabelStyle,),
                  const SizedBox(height: 3,),
                  Container(
                    child: Consumer<CreateTaskProvider>(
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            const SizedBox(width: 14,),
                            Expanded(
                              child: Text(value.task.dueDate!,style: const TextStyle(
                                  color: Colors.white24, fontSize: 16, fontWeight: FontWeight.w700
                              ),),
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today_rounded, color: Colors.white,),
                              onPressed: () async {
                                var date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.parse(createTaskProvider.task.dueDate!),
                                  firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365 * 100))
                                );
                                if (date != null) {
                                  createTaskProvider.setTaskDate = date;
                                }
                              },
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Divider(thickness: 1, color: Colors.white,)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check, color: Color(0xFF21BE57), size: 37,),
        onPressed: () => createTaskProvider.createTask(context),
        backgroundColor: Colors.white,
      ),
    );
  }
}
