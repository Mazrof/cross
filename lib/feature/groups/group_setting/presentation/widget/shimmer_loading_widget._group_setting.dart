import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            color: AppColors.primaryColor,
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.white,
                ),
                const SizedBox(width: AppSizes.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 150,
                      height: 15,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.md),
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.white,
          ),
          const SizedBox(height: AppSizes.md),
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.white,
          ),
          // Add more shimmer widgets here as needed
        ],
      ),
    );
  }
}
