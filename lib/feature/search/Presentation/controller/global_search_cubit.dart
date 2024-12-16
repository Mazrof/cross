import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/search/Presentation/controller/global_search_state.dart';
import 'package:telegram/feature/search/domain/use_cases/search_query_use_case.dart';

class GlobalSearchCubit extends Cubit<GlobalSearchState> {
  final SearchQueryUseCase searchQueryUseCase;

  GlobalSearchCubit({required this.searchQueryUseCase})
      : super(GlobalSearchState());

  Future<void> globalSearch(String query) async {
    emit(state.copyWith(state: CubitState.loading));
    final result = await searchQueryUseCase.call(query);

    result.fold(
      (failure) => emit(state.copyWith(
          state: CubitState.failure, errorMessage: failure.message)),
      (searchResult) => emit(state.copyWith(
        state: CubitState.success,
        channelResult: searchResult.channelResult,
        userResult: searchResult.userResult,
        groupResult: searchResult.groupResult,
      )),
    );
  }

  void updateCategory(SearchCategory category) {
    emit(state.copyWith(selectedCategory: category));
  }
}
