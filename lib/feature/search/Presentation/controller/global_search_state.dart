import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/search/domain/entities/global_search_entity.dart';

class GlobalSearchState extends Equatable {
  final CubitState state;
  final String? errorMessage;
  final List<UserSearchResult> userResult;
  final List<ChannelSearchResult> channelResult;
  final List<GroupSearchResult> groupResult;
  final SearchCategory selectedCategory;

  GlobalSearchState(
      {this.state = CubitState.initial,
      this.errorMessage,
      List<ChannelSearchResult>? channelResult,
      List<GroupSearchResult>? groupResult,
      List<UserSearchResult>? userResult,
      this.selectedCategory = SearchCategory.users})
      : channelResult = channelResult ?? [],
        userResult = userResult ?? [],
        groupResult = groupResult ?? [];

  GlobalSearchState copyWith({
    CubitState? state,
    String? errorMessage,
    List<UserSearchResult>? userResult,
    List<ChannelSearchResult>? channelResult,
    List<GroupSearchResult>? groupResult,
    SearchCategory? selectedCategory,
  }) {
    return GlobalSearchState(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      userResult: userResult ?? this.userResult,
      channelResult: channelResult ?? this.channelResult,
      groupResult: groupResult ?? this.groupResult,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        state,
        errorMessage,
        groupResult,
        channelResult,
        userResult,
        selectedCategory
      ];
}
