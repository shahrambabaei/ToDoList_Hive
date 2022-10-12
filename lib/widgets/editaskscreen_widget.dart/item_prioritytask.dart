import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_hive/config/color_theme.dart';

class ItemPriorityTask extends StatelessWidget {
  const ItemPriorityTask(
      {super.key,
      required this.label,
      required this.color,
      required this.onclick,
      required this.selcted});
  final String label;
  final Color color;
  final bool selcted;
  final GestureTapCallback onclick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 2, color: ColorTheme.secondaryTextColor.withOpacity(.2))),
        child: Stack(children: [
          Center(
            child: Text(label),
          ),
          Positioned(
              top: 0,
              bottom: 0,
              right: 5,
              child: checkBox(color: color, selected: selcted))
        ]),
      ),
    );
  }

//Checkbox
  Widget checkBox({required Color color, required bool selected}) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: selected
          ? const Icon(
              CupertinoIcons.check_mark,
              color: ColorTheme.onPrimaryColor,
              size: 14,
            )
          : null,
    );
  }
}
