import 'package:telegram/core/local/dp/dashboard/group_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<StoryModel>> fetchStories();
  Future<List<GroupModel>> fetchGroups();
  Future<List<ChannelModel>> fetchChannels();
  Future<List<ChatModel>> fetchContacts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<StoryModel>> fetchStories() async {
    // Implement the logic to fetch stories from the remote server
    // For example, using an HTTP client
    return [];
  }

  @override
  Future<List<GroupModel>> fetchGroups() async {
    // Implement the logic to fetch groups from the remote server
    return [];
  }

  @override
  Future<List<ChannelModel>> fetchChannels() async {
    // Implement the logic to fetch channels from the remote server
    return [];
  }

  @override
  Future<List<ChatModel>> fetchContacts() async {
    // Implement the logic to fetch contacts from the remote server
    return [];
  }
}
