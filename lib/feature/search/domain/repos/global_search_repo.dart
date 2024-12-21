import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/search/domain/entities/global_search_entity.dart';

abstract class GlobalSearchRepo {
  Future<Either<Failure, GlobalSearchEntity>> globalSearch(String query);
}
