import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/night_mode/presentation/controller/night_mode_cubit.dart';

class CNightModeSwitch extends StatelessWidget {
  const CNightModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sl<NightModeCubit>().toggleNightMode();
      },
      child: BlocBuilder<NightModeCubit, bool>(
        builder: (context, isNightMode) {
          return Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              color: isNightMode ? AppColors.primaryColor : AppColors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: isNightMode ? 30 : 0,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isNightMode
                          ? AppColors.whiteColor
                          : AppColors.primaryColor,
                    ),
                    child: Center(
                      child: Icon(
                        isNightMode ? Icons.nights_stay : Icons.wb_sunny,
                        color: isNightMode
                            ? AppColors.primaryColor
                            : AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                if (isNightMode)
                  const Positioned(
                    top: 10,
                    left: 10,
                    child: Icon(
                      Icons.star,
                      color: AppColors.whiteColor,
                      size: 15,
                    ),
                  ),
                if (isNightMode)
                  const Positioned(
                    top: 10,
                    left: 25,
                    child: Icon(
                      Icons.star,
                      color: AppColors.whiteColor,
                      size: 15,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
