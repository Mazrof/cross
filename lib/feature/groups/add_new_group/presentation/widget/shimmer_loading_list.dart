import 'package:flutter/material.dart';
import 'package:telegram/core/component/shimmer.dart';

class ShimmerLoadingList extends StatelessWidget {
  const ShimmerLoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          10, // You can adjust this number based on how many items you want to show in the loading state
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ShimmerWidget(
            child: Container(
              height: 60, // Adjust the height to match your list items
              color: Colors.grey[300],
            ),
          ),
        );
      },
    );
  }
}
