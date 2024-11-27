import 'package:flutter/material.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/home/presentation/widget/add_stroy.dart';
import 'package:telegram/feature/home/presentation/widget/app_drawer.dart';
import 'package:telegram/feature/home/presentation/widget/story.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  final int index = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CAppBar(
        leadingIcon: Icons.menu,
        title: Text('Telegram'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ],
        onLeadingTap: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stories Section
            Row(
              children: [
                index == 0
                    ? AddStoryWidget(
                        onTap: () {
                          // Add story logic
                        },
                      )
                    : StoryWidget(
                        imageUrl: AppAssetsStrings.general_person,
                        title: 'Kiro',
                        storyCount: 2,
                        isSeen: index.isEven,
                        numOfSeen: 2,
                      ),
                Container(
                  height: 120, // Adjust height
                  padding: EdgeInsets.all(8),
                  color: AppColors.primaryColor,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10, // Number of stories
                    itemBuilder: (context, index) {
                      return StoryWidget(
                        imageUrl: AppAssetsStrings.general_person,
                        title: 'Mariam',
                        storyCount: 3,
                        isSeen: false,
                        numOfSeen: 2,
                      );
                    },
                  ),
                ),
              ],
            ),
            // Chat Section

            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          // Add story logic
        },
        child: Icon(Icons.camera_alt, color: AppColors.whiteColor, size: 30),
      ),
    );
  }
}
