import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerChatPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              final isLeftAligned = index % 2 == 0; // Alternate message sides
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: isLeftAligned
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    if (isLeftAligned)
                      CircleAvatar(radius: 30), // Profile pic on the left
                    SizedBox(
                        width: isLeftAligned
                            ? 10
                            : 0), // Space between avatar and bubble
                    Flexible(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    if (!isLeftAligned)
                      SizedBox(width: 10), // Space for right-aligned avatar
                    if (!isLeftAligned)
                      CircleAvatar(radius: 20), // Profile pic on the right
                  ],
                ),
              );
            },
          ),
        ),
        _buildInputBarPlaceholder(),
      ],
    );
  }

  Widget _buildInputBarPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.add_circle, size: 24.0, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.send, size: 24.0, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
