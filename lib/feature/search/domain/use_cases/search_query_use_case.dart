import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/search/domain/entities/global_search_entity.dart';
import 'package:telegram/feature/search/domain/repos/global_search_repo.dart';

class SearchQueryUseCase extends BaseUseCase<GlobalSearchEntity, String> {
  GlobalSearchRepo globalSearchRepo;

  SearchQueryUseCase(
    this.globalSearchRepo,
  );

  @override
  Future<Either<Failure, GlobalSearchEntity>> call(String parameter) async {
    // TODO: implement call
    try {
      var result = await globalSearchRepo.globalSearch(parameter);
      return result;
    } catch (e) {
      return left(eitherM() as Failure);
    }
  }
}
