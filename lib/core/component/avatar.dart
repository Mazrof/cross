import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;
  const Avatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 10),
      width: AppSizes.iconLg,
      height: AppSizes.iconLg,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.fill),
        // color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
