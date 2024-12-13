import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/home/domain/repo/home_repo.dart';

class FetchChannelsUseCase {
  final HomeRepository repository;

  FetchChannelsUseCase({required this.repository});

  Future<List<ChannelModel>> call() async {
    return await repository.fetchChannels();
  }
}
