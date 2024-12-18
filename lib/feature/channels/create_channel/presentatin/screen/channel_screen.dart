import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/general_image.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({super.key, required this.channelData});
  final ChannelModel channelData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          GoRouter.of(context).pop();
        },
        title: GestureDetector(
          child: Row(
            children: [
              GeneralImage(
                username: channelData.name,
                imageUrl: '',
              ),
              Column(
                children: [
                  Text(channelData.name,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          onTap: () {
            GoRouter.of(context).push(AppRouter.kChannelSetting, extra: 4);
          },
        ),
      ),
      body: const Center(
        child: Text('Group Screen'),
      ),
    );
  }
}
