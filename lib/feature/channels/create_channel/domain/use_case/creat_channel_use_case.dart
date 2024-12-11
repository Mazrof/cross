
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/channels/create_channel/domain/repository/add_channel_repo.dart';

class CreateChannelUseCase {
  final ChannelRepository repository;

  CreateChannelUseCase(this.repository);

  Future<ChannelModel> call(ChannelModel channel) async {
    return await repository.createChannel(channel);
  }
}
