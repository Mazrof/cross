import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/feature/settings/datasettings/datasource/remotedata/user_settings_remote_data_source.dart';
import 'package:telegram/feature/settings/datasettings/models/user_settings_model.dart';
import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';
import 'package:telegram/feature/settings/domainsettings/repos/user_settings_repo.dart';

class GeneralFailure extends Failure {
  final String message;

  GeneralFailure({required this.message}) : super(message: message);
}

class UserSettingsRepoImpl extends UserSettingsRepo {
  final UserSettingsRemoteDataSource remoteDataSource;

  UserSettingsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserSettingsEntity>> fetchSettings() async {
    try {
      final settingsModel = await remoteDataSource.fetchSettings();
      return right(settingsModel.toEntity());
    } catch (error) {
      return left(GeneralFailure(message: error.toString()));
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
      return left(GeneralFailure(message: error.toString()));
    }
  }
}
