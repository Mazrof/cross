import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';

abstract class UserSettingsRepo {
  Future<Either<Failure, UserSettingsEntity>> fetchSettings();
  Future<Either<Failure, String>> updateSettings(UserSettingsEntity settings);
  Future<Either<Failure, UserSettingsEntity>> getBlocked();
  Future<Either<Failure, UserSettingsEntity>> getContacts();
  Future<Either<Failure, String>> blockUser(int blockedID);
  Future<Either<Failure, String>> unBlockUser(int blockedID);
}
