import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/feature/home/data/data_source/home_data_source.dart';
import 'package:telegram/feature/home/data/model/channel_data_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/group_data_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';
import 'package:telegram/feature/home/domain/repo/home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<StoryModel>> fetchStories() async {
    bool val = await sl<NetworkManager>().isConnected();
    if (!val) {
      // read from local

      //map list of json to list of  story model
      final data =
          HiveCash.read(boxName: "stories", key: "stories") as List<dynamic>?;

      if (data == null || data.isEmpty) {
        return [];
      }

      List<StoryModel> stories = data
          .map((json) => StoryModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();

      return stories;
    } else {
      //WRITE TO LOCAL

      List<StoryModel> stories = await remoteDataSource.fetchStories();
      HiveCash.openBox('stories');
      HiveCash.write(
          boxName: "stories",
          key: "stories",
          value: stories.map((e) => e.toJson()).toList());
      print('cash data of stories  ' +
          HiveCash.read(boxName: "stories", key: "stories").toString());
      return stories;
    }
  }

  @override
  Future<List<GroupDataModel>> fetchGroups() async {
    bool val = await sl<NetworkManager>().isConnected();
    if (!val) {
      // read from local
      final data =
          HiveCash.read(boxName: "groups", key: "groups") as List<dynamic>?;
      if (data == null || data.isEmpty || data == []) {
        return [];
      }
      print(data);

      List<GroupDataModel> groups = data
          .map((json) =>
              GroupDataModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
      return groups;
    } else {
      print('cash data of groups ');
      List<GroupDataModel> groups = await remoteDataSource.fetchGroups();
      HiveCash.openBox('groups');
      HiveCash.write(
          boxName: "groups",
          key: "groups",
          value: groups.map((e) => e.toJson()).toList());
      print('wait wait ');

      print(HiveCash.read(boxName: "groups", key: "groups"));
      return groups;
    }
    //  List<GroupDataModel> groups =await remoteDataSource.fetchGroups();
  }

  @override
  Future<List<ChannelDataModel>> fetchChannels() async {
    bool val = await sl<NetworkManager>().isConnected();
    if (!val) {
      // read from local

      final data =
          HiveCash.read(boxName: "channels", key: "channels") as List<dynamic>?;

      if (data == null || data.isEmpty) {
        return [];
      }

      List<ChannelDataModel> channels = data
          .map((json) =>
              ChannelDataModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
      return channels;
    } else {
      List<ChannelDataModel> channels = await remoteDataSource.fetchChannels();
      HiveCash.openBox('channels');
      HiveCash.write(
          boxName: "channels",
          key: "channels",
          value: channels.map((e) => e.toJson()).toList());

      print(HiveCash.read(boxName: "channels", key: "channels"));
      return channels;
    }
  }

  @override
  Future<List<ChatModel>> fetchContacts() async {
    bool isConnected = await sl<NetworkManager>().isConnected();
    if (!isConnected) {
      // Read from local storage
      print('in the local fetch');

      final data = (HiveCash.read(boxName: "contacts", key: "contacts")
              as List<dynamic>?)
          ?.map((e) => Map<String, dynamic>.from(e)) // Ensure type safety
          .toList();

      if (data == null || data.isEmpty||data==[]) {
        return [];
      }

      List<ChatModel> contacts =
          data.map((json) => ChatModel.fromJson(json)).toList();
      return contacts;
    } else {
      // Fetch from remote and save to local storage
      print('Fetching contacts from remote');
      List<ChatModel> contacts = await remoteDataSource.fetchContacts();
      HiveCash.openBox('contacts');
      HiveCash.write(
          boxName: "contacts",
          key: "contacts",
          value: contacts.map((e) => e.toJson()).toList());
      print('Saving contacts to local storage');
      return contacts;
    }
  }
}
