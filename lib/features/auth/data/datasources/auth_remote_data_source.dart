// coverage:ignore-file
import 'package:jhon_rhay_parreno_technical_assessment/core/error/exceptions.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/firebase/auth_service.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signinWithGoogle();
  Future<String> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final AuthService authService;

  const AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.authService,
  });

  @override
  Future<UserModel> signinWithGoogle() async {
    try {
      final response = await authService.signInWithGoogle();
      return UserModel.fromFirebaseUser(response!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(
          e.message ?? 'Unknown authentication error');
    } catch (e) {
      throw FirebaseException('An error occurred during sign-in');
    }
  }

  @override
  Future<String> logout() async {
    try {
      await authService.signOut();
      return "Succcessfully logout.";
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(e.message ?? 'Something went wrong');
    } catch (e) {
      throw FirebaseException('An error occurred during sign-in');
    }
  }
}
