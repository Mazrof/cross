class ChannelSearchResult {
  final int id;
  final String name;
  ChannelSearchResult({required this.id, required this.name});
}

class UserSearchResult {
  final int id;
  final String name;
  final String picVisibility;
  UserSearchResult(
      {required this.id, required this.name, required this.picVisibility});
}

class GroupSearchResult {
  final int id;
  final String name;
  GroupSearchResult({required this.id, required this.name});
}

class GlobalSearchEntity {
  final List<String> chats;
  final List<ChannelSearchResult> channelResult;
  final List<UserSearchResult> userResult;
  final List<GroupSearchResult> groupResult;

  GlobalSearchEntity(
      {required this.chats,
      required this.channelResult,
      required this.userResult,
      required this.groupResult});
}
