import 'package:flutter/material.dart';

class Welcomeage extends StatelessWidget {
   Welcomeage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcome",style: TextStyle(fontSize: 20),),
      ),
    );
  }
}