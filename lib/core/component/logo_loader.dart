import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class LogoLoader extends StatelessWidget {
  final double scale;
  final Color? color;
  const LogoLoader({super.key, this.scale = 1, this.color});

  final Curve _animationCurve = Curves.linear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo with vibration and rotation effect
          Image.asset(
            AppAssetsStrings.logoLoader, // Replace with your logo path
            width: 200 * scale,
            height: 200 * scale,
          )
              .animate(
                autoPlay: true,
                onPlay: (controller) =>
                    controller.repeat(), // Repeat indefinitely
              )
              // .animate(
              //     autoPlay: true, onPlay: (controller) => controller.repeat())
              // // Fade in at the beginning

              // Vibration effect (move horizontally)
              .moveX(
                duration: 600.ms,
                begin: -30 * scale,
                end: 20 * scale,
                curve: _animationCurve,
              )
              // Add slight rotation for vibration effect
              .then(delay: 200.ms) // No delay before fading in
              .fadeOut(
                duration: 200.ms,
                curve: _animationCurve,
              )
              .then(delay: 200.ms) // No delay before fading in
        ],
      )),
    );
  }
}
