import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class UserMedia extends StatelessWidget {
  const UserMedia({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://picsum.photos/200',
      'https://picsum.photos/200?random=1',
      'https://picsum.photos/200?random=2',
    ];

    return SliverFillRemaining(
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSizes.xs,
              mainAxisSpacing: AppSizes.xs,
            ),
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Image.network(imageUrls[index]);
            },
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSizes.xs,
              mainAxisSpacing: AppSizes.xs,
            ),
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Image.network(imageUrls[index]);
            },
          ),
        ],
      ),
    );

    // return SliverGrid(
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 3,
    //     crossAxisSpacing: AppSizes.sm,
    //     mainAxisSpacing: AppSizes.sm,
    //   ),
    //   delegate: SliverChildBuilderDelegate(
    //     (context, index) {
    //       return Image.network(imageUrls[index]);
    //     },
    //     childCount: imageUrls.length,
    //   ),
    // );
  }
}
