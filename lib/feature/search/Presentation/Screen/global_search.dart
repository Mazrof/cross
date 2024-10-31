import 'package:flutter/material.dart';

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
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          actions: [
            isTyping
                ? IconButton(
                    icon: Icon(Icons.clear),
                    color: Colors.black,
                    onPressed: () {},
                  )
                : SizedBox.shrink(),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: "Chats"),
              Tab(text: "Channels"),
              Tab(text: "Contacts"),
            ],
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Chat Search Result'),
                  subtitle: Text('...'),
                );
              },
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Channel Search Result'),
                  subtitle: Text('...'),
                );
              },
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Contact Search Result'),
                  subtitle: Text('...'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
