import 'package:flutter/material.dart';
import '../Widget/radio_tile.dart';

class AutodelMessages extends StatelessWidget {
  final AutoDelOption selectedTimer;
  const AutodelMessages({super.key, required this.selectedTimer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Auto-Delete Messages"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Icon(
              Icons.security,
              size: 80,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Self-Destruct Timer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: [
              RadioTile(
                  label: "Off", groupValue: selectedTimer.convertString()),
              Divider(
                thickness: 0.5,
              ),
              RadioTile(
                  label: "After 1 day",
                  groupValue: selectedTimer.convertString()),
              Divider(
                thickness: 0.5,
              ),
              RadioTile(
                  label: "After 1 day",
                  groupValue: selectedTimer.convertString()),
              Divider(
                thickness: 0.5,
              ),
              RadioTile(
                  label: "Off", groupValue: selectedTimer.convertString()),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'If enabled, all new messages in chats you start will be automatically deleted for everyone at some point after they are sent.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
