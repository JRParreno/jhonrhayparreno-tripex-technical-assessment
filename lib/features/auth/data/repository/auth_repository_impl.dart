import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/exceptions.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
    try {
      final response = await authRemoteDataSource.signinWithGoogle();
      return right(response);
    } on AuthenticationException catch (e) {
      return left(AuthenticationException(e.message));
    } on FirebaseException catch (e) {
      return left(FirebaseException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final response = await authRemoteDataSource.logout();
      return right(response);
    } on AuthenticationException catch (e) {
      return left(AuthenticationException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }
}
