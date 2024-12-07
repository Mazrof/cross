import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/feature/home/presentation/controller/story/add_story_cubit.dart';
import 'package:telegram/feature/home/presentation/controller/story/add_stroy_state.dart';

class CaptionInputScreen extends StatelessWidget {
  final String storyPath; // Path of the picked story

  const CaptionInputScreen({Key? key, required this.storyPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the AddStoryCubit to manage the story caption
    var storycaption = '';
    return BlocBuilder<AddStoryCubit, AddStoryState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the picked image
                  Center(
                    child: Image.file(
                      File(storyPath),
                      height: 400,
                      width: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Caption input field
                  TextField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    onChanged: (caption) {
                      // Update the caption in the cubit as the user types
                      storycaption = caption;
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Write a caption...',
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Submit Button to confirm the story with the caption
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle submitting the story with the caption
                        // You can call another cubit or function to save the story to the backend or update UI
                        sl<AddStoryCubit>().setStory(storyPath, storycaption);
                        Navigator.pop(context); // Go back after submitting
                      },
                      child: const Text('Post Story'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
