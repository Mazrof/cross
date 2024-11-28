import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/feature/home/presentation/controller/story/add_story_cubit.dart';
import 'package:telegram/feature/home/presentation/controller/story/stroy_cubit.dart';

class StoryViewerScreen extends StatelessWidget {
  final String imageUrl;
  final String caption;
  final String userName;
  final String userImage;
  final bool isOwner;

  const StoryViewerScreen({
    Key? key,
    required this.userImage,
    required this.userName,
    required this.imageUrl,
    required this.caption,
    this.isOwner = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoryViewerCubit(),
      child: BlocConsumer<StoryViewerCubit, double>(
        listener: (context, progress) {
          if (progress >= 1.0) {
            Navigator.pop(context); // Close the story when completed
          }
        },
        builder: (context, progress) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: GestureDetector(
              onTap: () {
                Navigator.pop(context); // End the story and navigate back
              },
              onLongPressStart: (_) {
                context.read<StoryViewerCubit>().startHolding();
              },
              onLongPressEnd: (_) {
                context.read<StoryViewerCubit>().stopHolding();
              },
              child: Stack(
                children: [
                  Center(
                    child: Image.file(
                      File(imageUrl),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          //check if falild add the default image

                          backgroundImage:

                              //check if falild add the default image
                              NetworkImage(userImage),

                          backgroundColor: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          userName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color.fromARGB(255, 43, 43, 43),
                      color: const Color.fromARGB(255, 226, 226, 226),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        caption,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  if (isOwner)
                    Positioned(
                      top: 40,
                      right: 20,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          // Handle story deletion
                          sl<AddStoryCubit>().resetStory();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
