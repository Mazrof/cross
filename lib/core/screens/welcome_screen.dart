import 'package:flutter/material.dart';
import 'package:telegram/core/component/welcome_screen_widgets/welcome_scroll.dart';

class TelegramWelcomeScreen extends StatelessWidget {
  const TelegramWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 27, 27),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WelcomeScroll(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Screen2 when the button is tapped
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       // builder: (context) => LoginScreen(),
                  //       ),
                  // );
                },
                child: const Text('JETZT BEGINNEN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
