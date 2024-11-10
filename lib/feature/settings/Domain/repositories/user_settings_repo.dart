import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/settings/Domain/entities/user_settings_entity.dart';

abstract class UserSettingsRepo {
  Future<Either<Failure, UserSettingsEntity>> fetchSettings();
  Future<Either<Failure, String>> updateSettings(UserSettingsEntity settings);
}
