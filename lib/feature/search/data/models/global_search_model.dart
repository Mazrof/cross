import 'package:telegram/feature/search/domain/entities/global_search_entity.dart';

class GlobalSearchModel extends GlobalSearchEntity {
  final List<String> chats;
  final List<ChannelSearchResult> channelResult;
  final List<UserSearchResult> userResult;
  final List<GroupSearchResult> groupResult;
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
      return UserSearchResult(
        id: userJson['id'] as int? ?? 0,
        name: userJson['username'] as String? ?? "",
        picVisibility: userJson['lastSeen'] as String? ?? "",
      );
    }).toList();

    final channels =
        (data['channels'] as List<dynamic>? ?? []).map((channelJson) {
      final community = channelJson['community'] ?? {};
      return ChannelSearchResult(
        id: channelJson['id'] as int? ?? 0,
        name: community['name'] as String? ?? 'Unknown',
      );
    }).toList();

    final groups = (data['groups'] as List<dynamic>? ?? []).map((groupJson) {
      final community = groupJson['community'] ?? {};
      return GroupSearchResult(
        id: groupJson['id'] as int? ?? 0,
        name: community['name'] as String? ?? 'Unknown',
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
