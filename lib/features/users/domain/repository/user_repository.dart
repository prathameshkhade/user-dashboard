import 'package:fpdart/fpdart.dart';
import 'package:userdashboard/features/users/domain/entity/user_entity.dart';

import '../../../../core/common/errors/failure.dart';

abstract interface class UserRepository {
  Future<Either<Failure ,List<UserEntity>>> getAllUsers();
}