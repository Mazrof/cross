import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class AddStoryState extends Equatable {
  final String? storyPath;
  final String? caption;
  final CubitState state;

  AddStoryState({
    this.state = CubitState.initial,
    this.storyPath,
    this.caption,
  });

  AddStoryState copyWith({
    String? storyPath,
    String? caption,
    CubitState? state,
  }) {
    return AddStoryState(
      storyPath: storyPath ?? this.storyPath,
      caption: caption ?? this.caption,
      state: state ?? this.state,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [storyPath, caption, state];
}
