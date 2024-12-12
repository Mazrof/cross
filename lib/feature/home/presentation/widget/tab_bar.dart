import 'package:flutter/material.dart';
import 'package:telegram/core/device/device.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/night_mode/presentation/controller/night_mode_cubit.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({
    super.key,
    required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    bool dark = sl<NightModeCubit>().state;

    return Material(
      color: dark ? AppColors.darkBackgroundColor : AppColors.whiteColor,
      child: TabBar(
        indicatorWeight: 2,
        isScrollable: false, // Make the TabBar non-scrollable
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        indicatorColor: AppColors.primaryColor,
        unselectedLabelColor: AppColors.grey,
        labelColor: dark ? AppColors.whiteColor : AppColors.primaryColor,
        tabs: tabs
            .map((tab) => Expanded(child: tab))
            .toList(), // Use Expanded for each tab
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtiles.getAppBarHeight());
}
