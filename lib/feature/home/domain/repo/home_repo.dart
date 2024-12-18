import 'package:telegram/core/local/dp/dashboard/group_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';

abstract class HomeRepository {
  Future<List<StoryModel>> fetchStories();
  Future<List<GroupModel>> fetchGroups();
  Future<List<ChannelModel>> fetchChannels();
  Future<List<ChatModel>> fetchContacts();
}
