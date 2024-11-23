import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/bottom_nav/presentaion/controller/nav_controller.dart';
import 'package:telegram/feature/bottom_nav/presentaion/controller/nav_state.dart';

class BottomNavBar extends StatelessWidget {
  NavCubit navController = sl<NavCubit>();

  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, NavState>(builder: (context, state) {
      return Scaffold(
          appBar: CAppBar(
            onLeadingTap: () {},
            showBackButton: false,
            title: Center(child: Text('Admin DashBoard')),
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.all(Theme.of(context)
                      .textTheme
                      .bodySmall // Set the desired font size here
                  ),
            ),
            child: NavigationBar(
              backgroundColor: AppColors.primaryColor.withOpacity(.001),
              indicatorColor: AppColors.primaryColor.withOpacity(.3),
              elevation: 0,
              selectedIndex: navController.state.index,
              onDestinationSelected: (index) {
                navController.updateCurrentIndex(index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Iconsax.user),
                  label: AppStrings.users,
                ),
                NavigationDestination(
                    icon: Icon(Icons.block), label: AppStrings.BanedUsers),
                NavigationDestination(
                    icon: Icon(Icons.group), label: AppStrings.Groubs),
              ],
            ),
          ),
          body: navController.screens[navController.state.index]);
    });
  }
}
