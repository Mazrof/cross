import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/voice/Presentation/Widget/call_log_tile.dart';

class CallLogScreen extends StatelessWidget {
  const CallLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CAppBar(
          leadingIcon: Icons.arrow_back,
          onLeadingTap: () {},
          title: Text("Call Log"),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete_calls') {}
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'delete_calls',
                    child: Text("Delete All Calls"),
                  )
                ];
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            CallLogTile(
                imageUrl:
                    "https://images.rawpixel.com/image_png_social_square/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvMzY2LW1ja2luc2V5LTIxYTc3MzYtZm9uLWwtam9iNjU1LnBuZw.png",
                contactName: "Contact")
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.call,
            color: AppColors.whiteColor,
          ),
          shape: CircleBorder(),
          backgroundColor: AppColors.lightBlueColor,
        ));
  }
}
