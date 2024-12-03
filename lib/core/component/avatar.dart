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
        //if you want to add image from assets
        image: DecorationImage(
          image: _getImageProvider(imageUrl),
          fit: BoxFit.fill,
        ),

        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  ImageProvider _getImageProvider(String url) {
    if (url.startsWith('http') || url.startsWith('https')) {
      return NetworkImage(url);
    } else {
      return AssetImage(url);
    }
  }
}
