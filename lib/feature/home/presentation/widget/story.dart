import 'package:flutter/material.dart';
import 'package:telegram/feature/home/presentation/widget/segment_border.dart';

class StoryWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int storyCount;
  final bool isSeen;
  final int numOfSeen;

  const StoryWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.storyCount,
    required this.isSeen,
     required this.numOfSeen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              CustomPaint(
                painter: SegmentedBorderPainter(
                  segments: storyCount,
                  numOfSeen: numOfSeen,
                  isSeen: isSeen,
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(imageUrl),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(title),
        ],
      ),
    );
  }
}
