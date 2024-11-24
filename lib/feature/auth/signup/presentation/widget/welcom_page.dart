import 'package:flutter/material.dart';

class Welcomeage extends StatelessWidget {
   const Welcomeage({super.key, Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcome",style: TextStyle(fontSize: 20),),
      ),
    );
  }
}