// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Group Invitation Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => HomePage(),
//         '/group': (context) => GroupPage(),
//       },
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String generatedLink = '';

//   @override
//   void initState() {
//     super.initState();
//     initDynamicLinks();
//   }

//   Future<void> createDynamicLink(String groupId, String token) async {
//     final dynamicLinkParams = DynamicLinkParameters(
//       link:
//           Uri.parse('https://example.com/invite?groupId=$groupId&token=$token'),
//       uriPrefix: 'https://yourapp.page.link',
//       androidParameters: const AndroidParameters(
//         packageName: 'com.example.yourapp',
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: 'com.example.yourapp',
//       ),
//     );

//     final dynamicLink =
//         await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
//     setState(() {
//       generatedLink = dynamicLink.shortUrl.toString();
//     });
//   }

//   void shareInviteLink() {
//     if (generatedLink.isNotEmpty) {
//       Share.share('Join our group using this link: $generatedLink');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please generate a link first.')),
//       );
//     }
//   }

//   void initDynamicLinks() {
//     FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData data) {
//       final Uri? deepLink = data.link;

//       if (deepLink != null) {
//         final groupId = deepLink.queryParameters['groupId'];
//         final token = deepLink.queryParameters['token'];

//         if (groupId != null && token != null) {
//           Navigator.pushNamed(context, '/group', arguments: groupId);
//         }
//       }
//     }).onError((error) {
//       print('Failed to handle dynamic link: $error');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home Page')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => createDynamicLink('12345', 'abcd1234'),
//               child: Text('Generate Invitation Link'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               generatedLink.isNotEmpty
//                   ? 'Generated Link: $generatedLink'
//                   : 'No link generated yet.',
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: shareInviteLink,
//               child: Text('Share Invitation Link'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class GroupPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final String groupId =
//         ModalRoute.of(context)?.settings.arguments as String? ?? 'Unknown';

//     return Scaffold(
//       appBar: AppBar(title: Text('Group Page')),
//       body: Center(
//         child: Text('Welcome to Group: $groupId'),
//       ),
//     );
//   }
// }
