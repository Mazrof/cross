import 'package:dartz/dartz.dart';
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/settings/domainsettings/repos/user_settings_repo.dart';

class BlockUserUseCase extends BaseUseCase<String, int> {
  final UserSettingsRepo userSettingsRepo;
  BlockUserUseCase(this.userSettingsRepo);

  @override
  Future<Either<Failure, String>> call(int parameter) async {
    return await userSettingsRepo.blockUser(parameter);
  }
}
