import 'package:bloc/bloc.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/channel_setting/domain/use_case/add_subscripers_use_case.dart';
import 'package:telegram/feature/channels/channel_setting/presentation/controller/add_subscribers_state.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/subscriber_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';

class SubscribersCubit extends Cubit<SubscribersState> {
  SubscribersCubit(
    this.addSubscribersUseCase,
    this.networkManager,
  ) : super(SubscribersState(
          state: CubitState.initial,
          allSubscribers: [],
          selectedSubscribers: [],
        ));

  final AddSubscribersUseCase addSubscribersUseCase;
  final NetworkManager networkManager;

  List<chatTileData> convertChatModelToChatTileData(
      List<ChatModel> chats, String currentUserId) {
    return chats.map((chat) {
      return chatTileData(
        id: chat.id,
        name: chat.secondUser.username,
        imageUrl: chat.secondUser.photo ?? '',
        lastSeen: chat.secondUser.lastSeen.toString(),
      );
    }).toList();
  }

  void loadContacts(ChannelModel channel) async {
    final int id = HiveCash.read(boxName: "register_info", key: "id");
    List<chatTileData> subscribers = convertChatModelToChatTileData(
        sl<HomeCubit>().state.contacts, id.toString());

    emit(SubscribersState(
      allSubscribers: subscribers,
      selectedSubscribers: [],
      channel: channel,
    ));
  }

  void toggleSubscriber(chatTileData subscriber) {
    final selectedSubscribers =
        List<chatTileData>.from(state.selectedSubscribers);

    if (selectedSubscribers.contains(subscriber)) {
      selectedSubscribers.remove(subscriber);
    } else {
      selectedSubscribers.add(subscriber);
    }

    emit(state.copyWith(
        selectedSubscribers: selectedSubscribers, state: CubitState.initial));
  }

  void addSubscribers() async {
    print('going to add subscribers');
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No Internet Connection'));
        return;
      }
      print(state.selectedSubscribers);
      await addSubscribersUseCase(
          state.channel!.id,
          state.selectedSubscribers.map((e) {
            return SubscriberModel(
              userId: e.id,
              role: 'subscriber',
              hasDownloadPermissions: true,
            );
          }).toList());
      emit(state.copyWith(state: CubitState.success));
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
