import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist_hive/config/color_theme.dart';
import 'package:todolist_hive/main.dart';
import 'package:todolist_hive/model/task.dart';
import 'package:todolist_hive/screens/edittask_screen.dart';
import 'package:todolist_hive/widgets/empty_state.dart';
import 'package:todolist_hive/widgets/homescreen_widget/body_listview.dart';
import 'package:todolist_hive/widgets/homescreen_widget/header_listview.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<String> searchKeywordNotifier = ValueNotifier('');

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
                    height: 43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: 10)
                        ],
                        color: ColorTheme.onPrimaryColor),
                    child: TextField(
                      onChanged: (value) {
                        searchKeywordNotifier.value = controller.text;
                      },
                      controller: controller,
                      decoration: const InputDecoration(
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
                child: ValueListenableBuilder<String>(
              valueListenable: searchKeywordNotifier,
              builder: (context, value, child) {
                return ValueListenableBuilder<Box<Task>>(
                  valueListenable: box.listenable(),
                  builder: (context, box, child) {
                    final List<Task> items;
                    if (controller.text.isEmpty) {
                      items = box.values.toList();
                    } else {
                      items = box.values
                          .where((element) =>
                              element.text.contains(controller.text))
                          .toList();
                    }
                    if (items.isNotEmpty) {
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 100),
                        itemCount: items.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const HeaderListView();
                          } else {
                            final Task task = items[index - 1];
                            return BodyListView(
                              task: task,
                            );
                          }
                        },
                      );
                    } else {
                      return const EmptyState();
                    }
                  },
                );
              },
            )),
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
