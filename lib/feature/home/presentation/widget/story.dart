import 'package:flutter/material.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/home/presentation/screen/story_screen.dart';

class StoryWidget extends StatelessWidget {
  final String userImage;
  final String userName;
  final bool isSeen;
  final String storyUrl;
  final String storyCaption;
  final bool isOwner;

  const StoryWidget({
    Key? key,
    required this.userImage,
    required this.storyCaption,
    required this.userName,
    required this.isSeen,
    required this.storyUrl,
    this.isOwner = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryViewerScreen(
              imageUrl: storyUrl,
              caption: storyCaption,
              userName: userName,
              userImage: userImage,
              isOwner: isOwner,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(3), // Border thickness
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSeen
                          ? Colors.grey.withOpacity(.5)
                          : const Color.fromARGB(255, 0, 192, 6),
                      width: 3,
                    ),
                  ),
                  child:Avatar(imageUrl: userImage,),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              userName,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
