import 'package:flutter/material.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

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
    return SizedBox(
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
              Text(
                userName,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: AppColors.whiteColor),
              ),
              Text(
                state,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: AppColors.whiteColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
