import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_hive/config/color_theme.dart';

class HeaderListView extends StatelessWidget {
  const HeaderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Container(
            height: 3,
            width: 70,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
                color: ColorTheme.primaryColor,
                borderRadius: BorderRadius.circular(2)),
          )
        ],
      ),
      MaterialButton(
        color: const Color(0xFfEAEFF5),
        textColor: ColorTheme.secondaryTextColor,
        elevation: 0,
        onPressed: () {},
        child: Row(children: const [
          Text('Delete All'),
          SizedBox(
            width: 3,
          ),
          Icon(
            CupertinoIcons.delete_solid,
            size: 20,
          )
        ]),
      )
    ]);
  }
}
