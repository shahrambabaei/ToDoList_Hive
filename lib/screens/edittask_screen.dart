import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist_hive/config/color_theme.dart';
import 'package:todolist_hive/main.dart';
import 'package:todolist_hive/model/task.dart';
import 'package:todolist_hive/widgets/editaskscreen_widget.dart/Item_prioritytask.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.task});
  final Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final box = Hive.box<Task>(taskBoxName);
    return Scaffold(
      backgroundColor: ColorTheme.surfaceColor,
      appBar: AppBar(
        backgroundColor: ColorTheme.surfaceColor,
        foregroundColor: ColorTheme.onSurfaceColor,
        elevation: 0,
        title: const Text('EditTask'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 100),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                  child: ItemPriorityTask(
                label: 'High',
                color: ColorTheme.highPriorityColor,
                onclick: () {
                  setState(() {
                    widget.task.priority = Priority.high;
                  });
                },
                selcted: widget.task.priority == Priority.high,
              )),
              const SizedBox(width: 15),
              Expanded(
                  child: ItemPriorityTask(
                label: 'Normal',
                color: ColorTheme.normalPriorityColor,
                onclick: () {
                  setState(() {
                    widget.task.priority = Priority.normal;
                  });
                },
                selcted: widget.task.priority == Priority.normal,
              )),
              const SizedBox(width: 15),
              Expanded(
                  child: ItemPriorityTask(
                label: 'low',
                color: ColorTheme.lowPriorityColor,
                onclick: () {
                  setState(() {
                    widget.task.priority = Priority.low;
                  });
                },
                selcted: widget.task.priority == Priority.low,
              )),
            ],
          ),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                label: Text('Add  a task for today...'),
                labelStyle:
                    TextStyle(fontSize:18, color: ColorTheme.secondaryTextColor)),
          )
        ]),
      ),
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
