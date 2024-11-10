import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/settings/Domain/entities/user_settings_entity.dart';
import 'package:telegram/feature/settings/Domain/repositories/user_settings_repo.dart';

class FetchSettingsUseCase
    extends BaseUseCase<UserSettingsEntity, NoParameters> {
  UserSettingsRepo userSettingsRepo;
  FetchSettingsUseCase(
    this.userSettingsRepo,
  );

  @override
  Future<Either<Failure, UserSettingsEntity>> call(
      NoParameters parameter) async {
    try {
      var result = await userSettingsRepo.fetchSettings();
      return result;
    } catch (error) {
      return left(error as Failure);
    }
  }
}
