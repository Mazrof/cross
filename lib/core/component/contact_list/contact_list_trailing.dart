import 'package:flutter/material.dart';

class ContactListTrailing extends StatelessWidget {
  final String sendingTime;
  final bool seen;
  final int unreadCount;
  const ContactListTrailing({
    super.key,
    required this.sendingTime,
    required this.unreadCount,
    required this.seen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          width: 80,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 6,
              ),
              child: Icon(seen ? Icons.done_all : Icons.done),
            ),
            Text(
              sendingTime,
              style: const TextStyle(fontSize: 16),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 30,
          height: 25,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: const BorderRadius.all(Radius.elliptical(80, 90)),
            border: Border.all(color: Colors.black, width: 0.0),
          ),
          child: Center(
              child: Text(
            unreadCount.toString(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
          )),
        )
      ],
    );
  }
}
