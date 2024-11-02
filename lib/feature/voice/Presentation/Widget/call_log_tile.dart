import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/voice/Presentation/Widget/call_log_tile_subtitle.dart';

class CallLogTile extends StatelessWidget {
  final String imageUrl;
  final String contactName;
  const CallLogTile(
      {super.key, required this.imageUrl, required this.contactName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Avatar(
        imageUrl: imageUrl,
      ),
      title: Text(
        contactName,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: const CallLogTileSubtitle(
          isIncoming: true, isMissed: true, callDate: "October 24 at 9:56 PM"),
      trailing: IconButton(
        onPressed: () {
          context.go(AppRouter.kvoiceCall);
        },
        icon: const Icon(
          Icons.call,
          color: AppColors.lightBlueColor,
        ),
      ),
    );
  }
}
