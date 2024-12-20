import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/home/data/model/channel_data_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/group_data_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<StoryModel>> fetchStories();
  Future<List<GroupDataModel>> fetchGroups();
  Future<List<ChannelDataModel>> fetchChannels();
  Future<List<ChatModel>> fetchContacts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  ApiService apiService = sl<ApiService>();
  @override
  Future<List<StoryModel>> fetchStories() async {
    return [];
  }

  @override
  Future<List<GroupDataModel>> fetchGroups() async {
    print('fetching channels in data source');
    String endpoint = 'chats/my-chats';
    var response = await apiService.get(
      endPoint: endpoint,
      queryParameters: {
        "type": "group",
      },
    );

    print('Raw Response: ${response.data}');

    // Extract and cast the list
    List<dynamic> data = response.data as List<dynamic>;
    // print('Raw Data: ${data[0]}');

    // Map the response to a list of GroupDataModel
    List<GroupDataModel> groups = data
        .map((json) => GroupDataModel.fromJson(json as Map<String, dynamic>))
        .toList();

    print('Parsed Groups: ${groups.toString()}');
    return groups;
  }

  @override
  Future<List<ChannelDataModel>> fetchChannels() async {
    print('fetching channels in data source');
    String endpoint = 'chats/my-chats';
    var response = await apiService.get(
      endPoint: endpoint,
      queryParameters: {
        "type": "channel",
      },
    );
    print(response.data);
    List<dynamic> data = response.data as List<dynamic>;

    return data.map((json) => ChannelDataModel.fromJson(json)).toList();
  }

  @override
  Future<List<ChatModel>> fetchContacts() async {
    print('fetching channels in data source');
    String endpoint = 'chats/my-chats';
    var response = await apiService.get(
      endPoint: endpoint,
      queryParameters: {
        "type": "personalChat",
      },
    );
    // print("contacts:" + response.data);
    List<dynamic> data = response.data as List<dynamic>;

    return data.map((json) => ChatModel.fromJson(json)).toList();
  }
}
