import 'package:flutter/material.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/home/presentation/widget/add_stroy.dart';
import 'package:telegram/feature/home/presentation/widget/app_drawer.dart';
import 'package:telegram/feature/home/presentation/widget/chat_tile.dart';
import 'package:telegram/feature/home/presentation/widget/story.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
// Create a GlobalKey to access ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey here

      drawer: const CAppDrawer(),
      appBar: CAppBar(
        leadingIcon: Icons.menu,
        title: Text('Mazrof'),
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
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stories Section
            Container(
              color: AppColors.primaryColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: SizedBox(
                  height: 130, // Adjust height for the story section
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      AddStoryWidget(),
                      ...List.generate(
                        10, // Number of stories
                        (index) => StoryWidget(
                          userImage: AppAssetsStrings.general_person,
                          userName: 'User $index',
                          isSeen: index.isEven, // Example logic for seen status
                          storyUrl: AppAssetsStrings.general_person,
                          storyCaption: 'Caption $index',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Chat Section

            // Placeholder for chat items
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   scrollDirection: Axis.horizontal,
            //   itemCount: 10, // Number of chats
            //   itemBuilder: (context, index) {
            //     return ChatTileWidget(
            //         imageUrl: '',
            //         title: 'Kiro',
            //         subtitle: 'Hello there',
            //         onTap: () {
            //           // Open chat logic
            //         });
            //   },
            // ),
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
