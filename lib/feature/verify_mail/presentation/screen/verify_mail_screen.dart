import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:telegram/core/component/Capp_bar.dart';

class VerifyMailScreen extends StatelessWidget {
  final String email;

  const VerifyMailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        onLeadingTap: () {},
        showBackButton: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.email_outlined,
                size: 150,
                color: Colors.blue,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Check Your Email",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              "Please enter the code we have sent to your email",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              maskEmail(email),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Container(
              width: 250,
              margin: const EdgeInsets.all(24.0),
              child: PinCodeTextField(
                appContext: context,
                length: 5,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  inactiveColor: Colors.grey[350],
                  selectedColor: Colors.lightBlue,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {},
              ),
            )
          ],
        ),
      ),
    );
  }

  String maskEmail(String email) {
    String emailUsername = email.split('@')[0];
    String emailDomain = email.split('@')[1];

    String maskedUsername =
        "${emailUsername.substring(0, 2)}***${emailUsername[emailUsername.length - 1]}";

    return "$maskedUsername@$emailDomain";
  }
}
