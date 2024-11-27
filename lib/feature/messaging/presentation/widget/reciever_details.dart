import 'package:flutter/material.dart';
import 'package:telegram/core/component/avatar.dart';
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
    return SizedBox(
      height: AppSizes.xxl,
      width: AppSizes.receiverDetailsWidth,
      child: Row(
        children: [
          avatar,
          const SizedBox(width: AppSizes.md),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: Theme.of(context).textTheme.bodyMedium!),
              Text(state, style: Theme.of(context).textTheme.bodySmall!)
            ],
          )
        ],
      ),
    );
  }
}
