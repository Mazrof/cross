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
    return await remoteDataSource.fetchStories();
  }

  @override
  Future<List<GroupDataModel>> fetchGroups() async {
    return await remoteDataSource.fetchGroups();
  }

  @override
  Future<List<ChannelDataModel>> fetchChannels() async {
    return await remoteDataSource.fetchChannels();
  }

  @override
  Future<List<ChatModel>> fetchContacts() async {
    return await remoteDataSource.fetchContacts();
  }
}
