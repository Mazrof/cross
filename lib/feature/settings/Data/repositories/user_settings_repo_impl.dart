import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/settings/Data/data_source/remote_data/user_settings_remote_data_source.dart';
import 'package:telegram/feature/settings/Data/model/user_settings_model.dart';
import 'package:telegram/feature/settings/Domain/entities/user_settings_entity.dart';
import 'package:telegram/feature/settings/Domain/repositories/user_settings_repo.dart';

class UserSettingsRepoImpl extends UserSettingsRepo {
  final UserSettingsRemoteDataSource remoteDataSource;

  UserSettingsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserSettingsEntity>> fetchSettings() async {
    try {
      final settingsModel = await remoteDataSource.fetchSettings();
      return right(settingsModel.toEntity());
    } catch (error) {
      return left(error as Failure);
    }
  }

  @override
  Future<Either<Failure, String>> updateSettings(
      UserSettingsEntity settings) async {
    try {
      final model = UserSettingsBodyModel.fromEntity(settings);
      await remoteDataSource.updateSettings(model);
      return right("User Settings saved");
    } catch (error) {
      return left(error as Failure);
    }
  }
}
