import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void loadHomeData() {
    emit(state.copyWith(state: CubitState.loading));

    // Simulate loading data

    Future.delayed(Duration(seconds: 2), () {
      final List<ChatModel> chats = [
        ChatModel(
          id: 2,
          name: 'John Doe',
          imageUrl: '',
          lastMessage: 'Hello!',
          sender: 'John Doe',
          messageStatus: MessageStatus.delivered,
          time: '10:30 AM',
          lastSeen: '10:30 AM',
        ),
        ChatModel(
          id: 3,
          name: 'Jane Smith',
          imageUrl: '',
          lastMessage: 'How are you?',
          sender: 'Jane Smith',
          messageStatus: MessageStatus.loading,
          time: '9:15 AM',
          lastSeen: '9:15 AM',
        ),
      ];

      //stories
      final List<StoryModel> stories = [
        StoryModel(
          id: '1',
          createdAt: DateTime.now().subtract(Duration(hours: 1)),
          viewCount: 120,
          status: 'active',
          mediaType: 'image',
          mediaUrl: '',
          content: 'A beautiful sunrise!',
          userName: 'Alice',
          userImage: '',
          isSeen: false,
          isOwner: false,
        ),
        StoryModel(
          id: '2',
          createdAt: DateTime.now().subtract(Duration(hours: 2)),
          viewCount: 45,
          status: 'active',
          mediaType: 'video',
          mediaUrl: '',
          content: 'Chilling by the beach 🏖️',
          userName: 'Bob',
          userImage: '',
          isSeen: true,
          isOwner: false,
        ),
        StoryModel(
          id: '3',
          createdAt: DateTime.now().subtract(Duration(days: 1)),
          viewCount: 300,
          status: 'expired',
          mediaType: 'image',
          mediaUrl: '',
          content: 'Throwback to last weekend!',
          userName: 'Charlie',
          userImage: '',
          isSeen: true,
          isOwner: true,
        ),
        StoryModel(
          id: '4',
          createdAt: DateTime.now().subtract(Duration(minutes: 30)),
          viewCount: 10,
          status: 'active',
          mediaType: 'image',
          mediaUrl: '',
          content: 'Coffee time ☕',
          userName: 'Dana',
          userImage: '',
          isSeen: false,
          isOwner: false,
        ),
        StoryModel(
          id: '5',
          createdAt: DateTime.now().subtract(Duration(hours: 4)),
          viewCount: 85,
          status: 'active',
          mediaType: 'video',
          mediaUrl: '',
          content: 'Workout session 💪',
          userName: 'Eve',
          userImage: '',
          isSeen: true,
          isOwner: false,
        ),
      ];

// sort stories by isSeen
      stories.sort((a, b) => a.isSeen ? 1 : -1);
      emit(state.copyWith(
        chats: chats,
        stories: stories,
        state: CubitState.success,
      ));
    });
  }
}
