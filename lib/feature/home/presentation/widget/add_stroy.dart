import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/home/presentation/controller/story/add_story_cubit.dart';
import 'package:telegram/feature/home/presentation/controller/story/add_stroy_state.dart';
import 'package:telegram/feature/home/presentation/screen/caption_input_screen.dart';
import 'package:telegram/feature/home/presentation/widget/story.dart';

class AddStoryWidget extends StatelessWidget {
  const AddStoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();

    return BlocProvider.value(
      value: sl<AddStoryCubit>(),
      child: BlocBuilder<AddStoryCubit, AddStoryState>(
        builder: (context, state) {
          final storyPath = state.storyPath;
          final storycaption = state.caption;

          if (state.state == CubitState.loading) {
            // Show loading indicator while picking story
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage(AppAssetsStrings.general_person),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          } else if (state.state == CubitState.failure) {
            // Show error message if failed to pick story
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CSnackBar.showErrorSnackBar(
                  context, 'Error', 'Failed to pick story');
            });
          }

          if (storyPath == null) {
            // Show "Add Story" UI if no story is added
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
              child: GestureDetector(
                onTap: () async {
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: sl<AddStoryCubit>(),
                          child: CaptionInputScreen(
                            storyPath: pickedFile.path,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage(AppAssetsStrings.general_person),
                          backgroundColor: Colors.white,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Add Story',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Show the selected story and allow caption input
            return StoryWidget(
              userImage: AppAssetsStrings.general_person,
              userName: 'My Story',
              isSeen: true,
              storyUrl: storyPath,
              storyCaption:
                  state.caption?.isEmpty ?? true ? '' : state.caption!,
              isOwner: true,
            );
          }
        },
      ),
    );
  }
}
