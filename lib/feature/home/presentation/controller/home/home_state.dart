import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/home/domain/entity/story.dart';
import 'package:telegram/feature/home/domain/entity/chat.dart';

class HomeState extends Equatable {
  final List<Story> stories;
  final List<Chat> chats;
  final CubitState state;
  final bool hasOwnStory;

  HomeState({
    this.stories = const [],
    this.chats = const [],
    this.state = CubitState.initial,
    this.hasOwnStory = false,
  });

  HomeState copyWith({
    List<Story>? stories,
    List<Chat>? chats,
    CubitState? state,
    bool? hasOwnStory,
  }) {
    return HomeState(
      stories: stories ?? this.stories,
      chats: chats ?? this.chats,
      state: state ?? this.state,
      hasOwnStory: hasOwnStory ?? this.hasOwnStory,
    );
  }

  @override
  List<Object?> get props => [stories, chats, state, hasOwnStory];
}
