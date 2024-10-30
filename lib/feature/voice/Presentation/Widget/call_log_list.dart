import 'package:flutter/widgets.dart';
import 'package:telegram/feature/voice/Presentation/Widget/call_log_tile.dart';

class CallLogList extends StatelessWidget {
  const CallLogList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          CallLogTile(
              imageUrl:
                  "https://images.rawpixel.com/image_png_social_square/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvMzY2LW1ja2luc2V5LTIxYTc3MzYtZm9uLWwtam9iNjU1LnBuZw.png",
              contactName: "Contact");
        });
  }
}
