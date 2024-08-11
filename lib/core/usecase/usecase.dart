import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';

abstract interface class UseCase<SuccessfulType, Params> {
  Future<Either<Failure, SuccessfulType>> call(Params params);
}

class NoParams {}
