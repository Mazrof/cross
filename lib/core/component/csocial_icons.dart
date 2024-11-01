
import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class CSocialIcons extends StatelessWidget {
  const CSocialIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.lightBackgroundColor,
            border: Border.all(color: AppColors.dividerColor),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
              onPressed: () {},
              icon: const Image(image: AssetImage(AppAssetsStrings.google))),
        ),
        const SizedBox(width: AppSizes.md),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color:AppColors.lightBackgroundColor,
            border: Border.all(color: AppColors.dividerColor),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
              onPressed: () {},
              icon: const Image(image: AssetImage(AppAssetsStrings.facebook))),
        ),
        const SizedBox(width: AppSizes.md),
          Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.lightBackgroundColor,
            border: Border.all(color: AppColors.dividerColor),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
              onPressed: () {},
              icon: const Image(image: AssetImage(AppAssetsStrings.github))),
        ),

      ],
    );
  }
}
