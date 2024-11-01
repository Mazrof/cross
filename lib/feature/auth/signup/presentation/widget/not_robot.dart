// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:telegram/core/component/Capp_bar.dart';
// import 'package:telegram/core/routes/app_router.dart';
// import 'package:webview_flutter_plus/webview_flutter_plus.dart';

// class NotRobot extends StatefulWidget {
//   const NotRobot({Key? key}) : super(key: key);

//   @override
//   _NotRobotState createState() => _NotRobotState();
// }

// class _NotRobotState extends State<NotRobot> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:CAppBar(
//         onLeadingTap: (){
//           context.go(AppRouter.kSignUp);
//         },
//       title: const Text("Not a Robot"),
//       showBackButton: true,
//       actions:[],

//       )
//       ,
      
//       body: WebViewPlus(
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (controller) {
//           controller.loadUrl("assets/web_pages/index.html");
//         },
//         javascriptChannels: Set.from([
//           JavascriptChannel(
//             name: 'Captcha',
//             onMessageReceived: (JavascriptMessage message) {
//               context.go(AppRouter.kVerifyMail);
//             },
//           ),
//         ]),
//       ),
//     );
//   }

//   }
