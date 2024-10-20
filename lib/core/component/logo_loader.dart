import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart'; // Adjust as necessary
import 'package:telegram/core/utililes/app_colors/app_colors.dart'; // Adjust as necessary
import 'package:animated_text_kit/animated_text_kit.dart';

class LogoLoader extends StatelessWidget {
  const LogoLoader({Key? key, this.scale = 1}) : super(key: key);
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssetsStrings.loginLogo, // Replace with your logo path
              width: 200 * scale,
              height: 200 * scale,
            )
                .animate(
                  autoPlay: true,
                  onPlay: (controller) => controller.forward(), // Play once
                )
                .fadeIn(
                  duration: 2000.ms, // Duration for fading in
                ),
            SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Your World is Just One Chat Away', // Replace with your slogan
                  textStyle: TextStyle(
                    fontSize: 24 * scale,
                    color: AppColors.primaryColor,
                  ),
                  speed: const Duration(milliseconds: 100), // Speed of typing
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 0), // No pause between words
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ],
        ),
      ),
    );
  }
}
