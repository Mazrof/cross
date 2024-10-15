import 'package:flutter/material.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class RecieverDetails extends StatelessWidget {
  final String userName;
  final String state;
  final Avatar avatar;
  const RecieverDetails(
      {super.key,
      required this.userName,
      required this.state,
      required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      child: Row(
        children: [
          avatar,
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName,
                  style: const TextStyle(
                    fontSize: AppSizes.fontSizeVLg,
                  )),
              Text(state,
                  style: const TextStyle(
                    fontSize: AppSizes.fontSizeSm - 1,
                    color: AppColors.grey,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
