import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist_hive/main.dart';
import 'package:todolist_hive/model/task.dart';
import 'package:todolist_hive/screens/edittask_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Task>(taskBoxName);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomeScreen'),
        ),
        body: ValueListenableBuilder<Box<Task>>(
          valueListenable: box.listenable(),
          builder: (context, box, child) => ListView.builder(
        itemCount: box.values.length,
        itemBuilder: (context, index) {
          // final Task task = box.values.toList()[index];
          return Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(box.getAt(index)!.text),
          );
        },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditTaskScreen()));
            },
            label: Row(
              children: const [
                Text('Add New Task'),
                SizedBox(width: 4),
                Icon(CupertinoIcons.add_circled_solid)
              ],
            )),
      ),
    );
  }
}
