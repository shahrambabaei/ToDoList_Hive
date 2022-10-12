import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist_hive/main.dart';
import 'package:todolist_hive/model/task.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final box = Hive.box<Task>(taskBoxName);
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditTask'),
      ),
      body: Column(children: [
        TextField(
          controller: controller,
          decoration:
              const InputDecoration(label: Text('Add  a task for today...')),
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Task task = Task();
            task.text = controller.text;
            task.priority = Priority.low;
            if (task.isInBox) {
              task.save();
            } else {
              box.add(task);
            }
            Navigator.pop(context);
          },
          label: Row(
            children: const [
              Text('Save Change'),
              SizedBox(width: 4),
              Icon(CupertinoIcons.check_mark_circled_solid)
            ],
          )),
    );
  }
}
