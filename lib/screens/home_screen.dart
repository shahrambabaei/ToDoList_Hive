import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist_hive/config/color_theme.dart';
import 'package:todolist_hive/main.dart';
import 'package:todolist_hive/model/task.dart';
import 'package:todolist_hive/screens/edittask_screen.dart';
import 'package:todolist_hive/widgets/homescreen_widget/body_listview.dart';
import 'package:todolist_hive/widgets/homescreen_widget/header_listview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key,});
  

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Task>(taskBoxName);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorTheme.backgroundColor,
        body: Column(
          children: [
            Container(
              height: 115,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                ColorTheme.primaryColor,
                ColorTheme.primaryContainerColor
              ])),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To Do List',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Icon(Icons.menu, color: ColorTheme.onPrimaryColor)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: 10)
                        ],
                        color: ColorTheme.onPrimaryColor),
                    child: const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                        ),
                        hintText: 'Search task...',
                      ),
                    ),
                  )
                ]),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<Task>>(
                valueListenable: box.listenable(),
                builder: (context, box, child) => ListView.builder(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 100),
                  itemCount: box.values.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return HeaderListView();
                    } else {
                      final Task task = box.values.toList()[index - 1];
                      return BodyListView(
                        task: task,
                      );
                    }
                    // return Container(
                    //   margin: const EdgeInsets.only(top: 10),
                    //   child: Text(box.getAt(index-1)!.text),
                    // );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditTaskScreen(
                            task: Task(),
                          )));
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
