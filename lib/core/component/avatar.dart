import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;
  const Avatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.fill),
        // color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
