import 'package:telegram/core/local/dp/dashboard/group_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/home/data/model/channel_data_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/group_data_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';

abstract class HomeRepository {
  Future<List<StoryModel>> fetchStories();
  Future<List<GroupDataModel>> fetchGroups();
  Future<List<ChannelDataModel>> fetchChannels();
  Future<List<ChatModel>> fetchContacts();
}
