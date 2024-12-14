import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  final bool isTyping;
  const SearchAppBar({super.key, required this.isTyping});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.brown,
          ),
          onPressed: () {},
        ),
      ),
      title: const TextField(
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
                icon: const Icon(Icons.clear),
                color: Colors.brown,
                onPressed: () {},
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
