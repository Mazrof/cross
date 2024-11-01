import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/voice/Presentation/Widget/voice_icon.dart';
import 'package:animate_gradient/animate_gradient.dart';

class VoiceCallScreen extends StatelessWidget {
  final bool isMuted;
  final bool speakerMode;
  final String callStatus;
  final String contactName;
  final String contactImage;

  const VoiceCallScreen({
    super.key,
    required this.isMuted,
    required this.speakerMode,
    required this.callStatus,
    required this.contactName,
    required this.contactImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
        primaryColors: const [
          Colors.purple,
          Colors.purpleAccent,
          Colors.grey,
        ],
        secondaryColors: const [
          Colors.blue,
          Colors.blueAccent,
          Colors.grey,
        ],
        duration: const Duration(seconds: 2),
        reverse: true,
        animateAlignments: true,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 128.0),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.green,
                backgroundImage:
                    AssetImage('assets/images/chat_background.png'),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              contactName,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 5),
            Text(
              callStatus,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                VoiceIcon(
                  icon: speakerMode
                      ? Icons.volume_up_outlined
                      : Icons.volume_off_outlined,
                  label: AppStrings.speaker,
                  isPressed: !speakerMode,
                  onTap: () {},
                  activeColor: Colors.white,
                  inactiveColor: Colors.white.withOpacity(0.2),
                ),
                VoiceIcon(
                  icon: isMuted ? Icons.mic_off_outlined : Icons.mic_outlined,
                  label: isMuted ? AppStrings.unmute : AppStrings.mute,
                  isPressed: isMuted,
                  onTap: () {},
                  activeColor: Colors.white,
                  inactiveColor: Colors.white.withOpacity(0.2),
                ),
                VoiceIcon(
                  icon: Icons.call_end_rounded,
                  label: AppStrings.endCall,
                  isPressed: false,
                  onTap: () {
                    context.go(AppRouter.kcallLog);
                  },
                  activeColor: Colors.red,
                  inactiveColor: Colors.red,
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
