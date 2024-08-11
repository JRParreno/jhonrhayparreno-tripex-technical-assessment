import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/usecase/usecase.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/repository/auth_repository.dart';

class UserGoogleSignin implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  const UserGoogleSignin(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.signinWithGoogle();
  }
}
