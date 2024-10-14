import 'package:flutter/material.dart';

class WelcomeScrollItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subText;

  const WelcomeScrollItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Icon(
            icon,
            size: 100,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(4, (index) {
          //     return Container(
          //       margin: EdgeInsets.symmetric(horizontal: 4),
          //       width: 8,
          //       height: 8,
          //       decoration: const BoxDecoration(
          //         color: Colors.white,
          //         shape: BoxShape.circle,
          //       ),
          //     );
          //   }),
          // ),
          // const SizedBox(height: 20),