import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/search/Presentation/Widget/search_result_tile.dart';

class GlobalSearchScreen extends StatelessWidget {
  final bool isTyping;

  const GlobalSearchScreen({super.key, required this.isTyping});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
              onPressed: () {},
            ),
          ),
          title: const TextField(
            maxLength: 40,
            decoration: InputDecoration(
              counterText: "",
              hintText: 'Search...',
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          actions: [
            isTyping
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    color: Theme.of(context).textTheme.titleLarge!.color,
                    onPressed: () {},
                  )
                : const SizedBox.shrink(),
          ],
          bottom: TabBar(
            tabs: const [
              Tab(text: AppStrings.chats),
              Tab(text: AppStrings.channels),
              Tab(text: AppStrings.contacts),
            ],
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            labelStyle: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => const SearchResultTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                searchTitle: "Chat Result",
                searchSubtitle: Text("Message"),
                trailing: Text("16.04.23"),
              ),
            ),
            ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => const SearchResultTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                searchTitle: "Channel Result",
              ),
            ),
            ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => const SearchResultTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                searchTitle: "Contact Result",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
