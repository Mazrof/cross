import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu(this._popupList, {super.key, required this.actions});

  final List<dynamic> _popupList;
  final List<dynamic> actions;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, AppSizes.xxl),
      onSelected: (String result) {
        // Handle menu item selection
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        for (int i = 0; i < _popupList.length; i++)
          PopupMenuItem<String>(
            value: _popupList[i]['value'],
            child: ListTile(
              leading: Icon(_popupList[i]['icon']),
              title: Text(_popupList[i]['value']),
            ),
            onTap: actions[i],
          ),
      ],
      constraints: const BoxConstraints(maxWidth: 200),
      icon: const Icon(
        Icons.more_vert,
        color: AppColors.whiteColor,
      ),
    );
  }
}
