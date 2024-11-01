import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telegram/core/device/device.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CAppBar(
      {super.key,
      this.title,
      this.showBackButton = false,
      this.leadingIcon,
      this.actions,
      required this.onLeadingTap});
  final Widget? title;
  final bool showBackButton;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback onLeadingTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      titleTextStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .apply(color: AppColors.whiteColor),
      title: title,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Iconsax.arrow_left, color: AppColors.whiteColor),
              onPressed: onLeadingTap,
            )
          : leadingIcon != null
              ? IconButton(
                  icon: Icon(leadingIcon, color: AppColors.whiteColor),
                  onPressed: onLeadingTap,
                )
              : null,
      actions: [
        ...actions ?? [Container()],
      ],
    );
  }

  @override
  Size get preferredSize {
    const context = null; // Replace null with the appropriate context variable
    return Size.fromHeight(DeviceUtiles.getAppBarHeight());
  }
}
