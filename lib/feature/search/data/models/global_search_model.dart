import 'package:telegram/feature/search/domain/entities/global_search_entity.dart';

class GlobalSearchModel extends GlobalSearchEntity {
  final List<String> chats;
  final List<Channel> channelResult;
  final List<User> userResult;
  final List<Group> groupResult;
  GlobalSearchModel({
    required this.chats,
    required this.channelResult,
    required this.userResult,
    required this.groupResult,
  }) : super(
          chats: chats,
          channelResult: channelResult,
          userResult: userResult,
          groupResult: groupResult,
        );

  GlobalSearchEntity toEntity() {
    return GlobalSearchEntity(
        chats: chats,
        channelResult: channelResult,
        userResult: userResult,
        groupResult: groupResult);
  }

  factory GlobalSearchModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    final users = (data['users'] as List<dynamic>? ?? []).map((userJson) {
      return User(
        id: userJson['id'] as int,
        name: userJson['name'] as String,
        picVisibility: userJson['profilepicvisibility'] as String,
      );
    }).toList();

    final channels =
        (data['channels'] as List<dynamic>? ?? []).map((channelJson) {
      return Channel(
        id: channelJson['id'] as int,
        name: channelJson['name'] as String,
      );
    }).toList();

    final groups = (data['groups'] as List<dynamic>? ?? []).map((groupJson) {
      return Group(
        id: groupJson['id'] as int,
        name: groupJson['name'] as String,
      );
    }).toList();

    return GlobalSearchModel(
      chats: [],
      channelResult: channels,
      userResult: users,
      groupResult: groups,
    );
  }

  static empty() {
    return GlobalSearchModel(
      chats: [],
      channelResult: [],
      userResult: [],
      groupResult: [],
    );
  }
}
