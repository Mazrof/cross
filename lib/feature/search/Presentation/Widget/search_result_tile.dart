import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchResultTile extends StatelessWidget {
  final String searchTitle;
  final Widget? leading;
  final Widget? searchSubtitle;
  final Widget? trailing;

  const SearchResultTile(
      {super.key,
      required this.searchTitle,
      this.searchSubtitle,
      this.trailing,
      this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        searchTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: searchSubtitle,
      trailing: trailing,
    );
  }
}
