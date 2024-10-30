import 'dart:async';
import 'package:flutter/material.dart';
import 'package:telegram/feature/voice/Presentation/Widget/voice_icon.dart';

class VoiceCallScreen extends StatefulWidget {
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
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<VoiceCallScreen> {
  bool _toggle = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        _toggle = !_toggle;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 4),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: _toggle
                ? [Colors.blue, Colors.purple]
                : [Colors.purple, Colors.blue],
            radius: 10,
            center: Alignment.center,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 128.0),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.green,
                backgroundImage:
                    AssetImage('assets/images/chat_background.png'),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.contactName,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 5),
            Text(
              widget.callStatus,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                VoiceIcon(
                  icon: widget.speakerMode
                      ? Icons.volume_up_outlined
                      : Icons.volume_off_outlined,
                  label: "Speaker",
                  isPressed: !widget.speakerMode,
                  onTap: () {},
                  activeColor: Colors.white,
                  inactiveColor: Colors.white.withOpacity(0.2),
                ),
                VoiceIcon(
                  icon: widget.isMuted
                      ? Icons.mic_off_outlined
                      : Icons.mic_outlined,
                  label: widget.isMuted ? "Unmute" : "Mute",
                  isPressed: widget.isMuted,
                  onTap: () {},
                  activeColor: Colors.white,
                  inactiveColor: Colors.white.withOpacity(0.2),
                ),
                VoiceIcon(
                  icon: Icons.call_end_rounded,
                  label: "End Call",
                  isPressed: false,
                  onTap: () {},
                  activeColor: Colors.red,
                  inactiveColor: Colors.red,
                )
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
