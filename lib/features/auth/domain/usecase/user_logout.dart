import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/usecase/usecase.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/repository/auth_repository.dart';

class UserLogout implements UseCase<String, NoParams> {
  final AuthRepository authRepository;

  const UserLogout(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
