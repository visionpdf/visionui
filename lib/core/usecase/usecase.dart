import 'package:fpdart/fpdart.dart';
import 'package:visionui/core/exception/failure.dart';

abstract interface class Usecase<T, Parameters> {
  Future<Either<T, Failure>> call(Parameters parameters);
}

class NoParams {}
