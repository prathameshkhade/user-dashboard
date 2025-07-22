import 'package:fpdart/fpdart.dart';
import 'package:userdashboard/core/common/errors/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}