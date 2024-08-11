import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';

class ServerException extends Failure {
  ServerException(super.message);
}

class AuthenticationException extends Failure {
  AuthenticationException(super.message);
}

class FirebaseException extends Failure {
  FirebaseException(super.message);
}
