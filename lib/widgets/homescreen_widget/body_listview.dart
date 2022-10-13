import 'package:flutter/material.dart';
import 'package:todolist_hive/config/color_theme.dart';
import 'package:todolist_hive/model/task.dart';
import 'package:todolist_hive/screens/edittask_screen.dart';

class BodyListView extends StatefulWidget {
  const BodyListView({super.key, required this.task});
  final Task task;

  @override
  State<BodyListView> createState() => _BodyListViewState();
}

class _BodyListViewState extends State<BodyListView> {
  late Color priorityColor;

  @override
  Widget build(BuildContext context) {
    switch (widget.task.priority) {
      case Priority.high:
        priorityColor = ColorTheme.highPriorityColor;
        break;
      case Priority.normal:
        priorityColor = ColorTheme.normalPriorityColor;
        break;
      case Priority.low:
        priorityColor = ColorTheme.lowPriorityColor;
        break;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(task: widget.task),
              ));
        },
        child: Container(
          height: 75,
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorTheme.surfaceColor),
          child: Row(children: [
            myCheckBox(
              isActived: widget.task.isCompleted,
              onClick: () {
                setState(() {
                  widget.task.isCompleted = !widget.task.isCompleted;
                });
              },
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                widget.task.text,
                style: TextStyle(
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null),
              ),
            ),
            const SizedBox(width: 15),
            Container(
              width: 7,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
            )
          ]),
        ),
      ),
    );
  }

  Widget myCheckBox({required bool isActived, required Function() onClick}) {
    return InkWell(
      onTap: onClick,
      child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  !isActived ? Border.all(color: Colors.grey, width: 2) : null,
              color: isActived ? ColorTheme.primaryColor : null),
          child: isActived
              ? const Icon(
                  Icons.check,
                  color: ColorTheme.onPrimaryColor,
                  size: 18,
                )
              : null),
    );
  }
}
