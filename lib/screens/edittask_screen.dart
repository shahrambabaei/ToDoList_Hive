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
 late final TextEditingController controller = TextEditingController(text: widget.task.text);
  final box = Hive.box<Task>(taskBoxName);
  @override
  Widget build(BuildContext context) {
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
                selcted: widget.task.priority == Priority.high,
                onclick: () {
                  setState(() {
                    widget.task.priority = Priority.high;
                  });
                },
              )),
              const SizedBox(width: 15),
              Expanded(
                  child: ItemPriorityTask(
                label: 'Normal',
                color: ColorTheme.normalPriorityColor,
                selcted: widget.task.priority == Priority.normal,
                onclick: () {
                  setState(() {
                    widget.task.priority = Priority.normal;
                  });
                },
              )),
              const SizedBox(width: 15),
              Expanded(
                  child: ItemPriorityTask(
                label: 'low',
                color: ColorTheme.lowPriorityColor,
                selcted: widget.task.priority == Priority.low,
                onclick: () {
                  setState(() {
                    widget.task.priority = Priority.low;
                  });
                },
              )),
            ],
          ),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                label: Text('Add  a task for today...'),
                labelStyle: TextStyle(
                    fontSize: 18, color: ColorTheme.secondaryTextColor)),
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            widget.task.text = controller.text;
            widget.task.priority = widget.task.priority;
            if (widget.task.isInBox) {
              widget.task.save();
            } else {
              box.add(widget.task);
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
