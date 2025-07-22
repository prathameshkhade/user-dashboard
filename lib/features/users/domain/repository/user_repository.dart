import 'package:fpdart/fpdart.dart';
import 'package:userdashboard/core/errors/failure.dart';
import 'package:userdashboard/features/users/domain/entity/user_entity.dart';

abstract interface class UserRepository {
  Future<Either<Failure ,List<UserEntity>>> getAllUsers();
}