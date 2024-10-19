import 'package:flutter/material.dart';
import '../Widget/radio_tile.dart';

class LastseenOnlineScreen extends StatelessWidget {
  final PrivacyOption selectedOption;
  const LastseenOnlineScreen({super.key, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Last seen & online"),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView(padding: const EdgeInsets.all(16.0), children: [
        Text(
          'Who can see my last seen time?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: [
            RadioTile(
                label: 'Everybody', groupValue: selectedOption.convertString()),
            Divider(
              thickness: 0.5,
            ),
            RadioTile(
                label: 'My Contacts',
                groupValue: selectedOption.convertString()),
            Divider(
              thickness: 0.5,
            ),
            RadioTile(
                label: 'Nobody', groupValue: selectedOption.convertString()),
          ],
        ),
      ]),
    );
  }
}
