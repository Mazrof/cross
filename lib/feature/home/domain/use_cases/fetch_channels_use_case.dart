import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/home/data/model/channel_data_model.dart';
import 'package:telegram/feature/home/domain/repo/home_repo.dart';

class FetchChannelsUseCase {
  final HomeRepository repository;

  FetchChannelsUseCase({required this.repository});

  Future<List<ChannelDataModel>> call() async {
    return await repository.fetchChannels();
  }
}
