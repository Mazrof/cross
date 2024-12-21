import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/search/data/data_source/global_search_remote_data_source.dart';
import 'package:telegram/feature/search/domain/entities/global_search_entity.dart';
import 'package:telegram/feature/search/domain/repos/global_search_repo.dart';

class GeneralFailure extends Failure {
  final String message;

  GeneralFailure({required this.message}) : super(message: message);
}

class GlobalSearchRepoImpl extends GlobalSearchRepo {
  final GlobalSearchRemoteDataSource remoteDataSource;

  GlobalSearchRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, GlobalSearchEntity>> globalSearch(String query) async {
    try {
      final globalSearchModel = await remoteDataSource.searchGlobal(query);
      return right(globalSearchModel.toEntity());
    } catch (e) {
      return left(GeneralFailure(message: e.toString()));
    }
  }
}
