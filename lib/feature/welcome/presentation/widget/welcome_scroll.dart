import 'package:flutter/material.dart';
import 'package:telegram/feature/welcome/presentation/widget/welcome_scroll_item.dart';

class WelcomeScroll extends StatelessWidget {
  final List<dynamic> items = [
    {
      'icon': Icons.telegram,
      'title': "Telegram",
      'subText': "Die schnellste Messaging App der Welt. Kostenlos und sicher."
    },
    {
      'icon': Icons.speed,
      'title': "Schnell",
      'subText':
          "Telegram übermittelt Nachrichten schneller als jede andere Amwendung."
    },
    {
      'icon': Icons.card_giftcard,
      'title': "Kostenlos",
      'subText':
          "Telegram bietet unbegrenzt viel Cloud-Speicher für Chats und Medien."
    },
  ];

  WelcomeScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Adjust the height as needed
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            // color: Colors.blueAccent,
            child: WelcomeScrollItem(
              icon: items[index]['icon'],
              title: items[index]['title'],
              subText: items[index]['subText'],
            ),
          );
        },
      ),
    );
  }
}
