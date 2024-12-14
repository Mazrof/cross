class Channel {
  final int id;
  final String name;
  Channel({required this.id, required this.name});
}

class User {
  final int id;
  final String name;
  final String picVisibility;
  User({required this.id, required this.name, required this.picVisibility});
}

class Group {
  final int id;
  final String name;
  Group({required this.id, required this.name});
}

class GlobalSearchEntity {
  final List<String> chats;
  final List<Channel> channelResult;
  final List<User> userResult;
  final List<Group> groupResult;

  GlobalSearchEntity(
      {required this.chats,
      required this.channelResult,
      required this.userResult,
      required this.groupResult});
}
