import 'package:flutter/material.dart';
import 'package:flutter_gcaptcha_v3/recaptca_config.dart';
import 'package:flutter_gcaptcha_v3/web_view.dart';

class ReCaptchaWidget extends StatefulWidget {
  final Function(String) onTokenReceived;

  const ReCaptchaWidget({super.key, required this.onTokenReceived});

  @override
  _ReCaptchaWidgetState createState() => _ReCaptchaWidgetState();
}

class _ReCaptchaWidgetState extends State<ReCaptchaWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReCaptchaWebView(
          width: 200,
          height: 22,
          webViewColor: null,
          onTokenReceived: widget.onTokenReceived,
          url: 'https://www.google.com/recaptcha/api2/demo',
        ),
        ElevatedButton(
          onPressed: execute,
          child: const Text('Verify'),
        )
      ],
    );
  }

  void execute() => RecaptchaHandler.executeV3();
}