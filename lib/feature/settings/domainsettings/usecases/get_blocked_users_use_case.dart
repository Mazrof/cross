import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';
import 'package:telegram/feature/settings/domainsettings/repos/user_settings_repo.dart';

class GetBlockedUsersUseCase
    extends BaseUseCase<UserSettingsEntity, NoParameters> {
  UserSettingsRepo userSettingsRepo;
  GetBlockedUsersUseCase(this.userSettingsRepo);

  @override
  Future<Either<Failure, UserSettingsEntity>> call(
      NoParameters parameter) async {
    try {
      var result = await userSettingsRepo.getBlocked();
      return result;
    } catch (error) {
      return left(error as Failure);
    }
  }
}
