
import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';

abstract class LocalRepository {
  Future<Either<Failure, void>> clearAll();
  Future<Either<Failure, void>> cacheToken(String token);
  Future<Either<Failure, String?>> getCachedToken();
  Future<Either<Failure, void>> cacheUserData(Map<String, dynamic> user);
  Future<Either<Failure, Map<String, dynamic>?>> getUserData();
  Future<Either<Failure, void>> removeUserData();
}