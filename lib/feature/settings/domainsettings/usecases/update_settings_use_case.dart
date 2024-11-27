import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';
import 'package:telegram/feature/settings/domainsettings/repos/user_settings_repo.dart';

class UpdateSettingsUseCase extends BaseUseCase<String, UserSettingsEntity> {
  final UserSettingsRepo userSettingsRepo;
  UpdateSettingsUseCase(this.userSettingsRepo);

  @override
  Future<Either<Failure, String>> call(UserSettingsEntity parameter) async {
    return await userSettingsRepo.updateSettings(parameter);
  }
}
