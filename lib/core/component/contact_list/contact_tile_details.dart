import 'package:flutter/material.dart';

class ContactTileDetails extends StatelessWidget {
  final String contactName;
  final String lastMessage;
  const ContactTileDetails(
      {super.key, required this.contactName, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contactName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          lastMessage,
          style: const TextStyle(color: Color.fromARGB(255, 130, 128, 128)),
        ),
      ],
    );
  }
}
