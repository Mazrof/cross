import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:telegram/core/component/avatar.dart';
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
      subtitle: CallLogTileSubtitle(
          isIncoming: true, isMissed: true, callDate: "October 24 at 9:56 PM"),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.call,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
