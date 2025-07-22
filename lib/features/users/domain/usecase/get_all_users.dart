import 'package:fpdart/fpdart.dart';
import 'package:userdashboard/core/common/errors/failure.dart';
import 'package:userdashboard/core/common/usecase/usecase.dart';
import 'package:userdashboard/features/users/domain/entity/user_entity.dart';
import 'package:userdashboard/features/users/domain/repository/user_repository.dart';

class GetAllUsersUseCase implements UseCase<List<UserEntity> , NoParams> {
  final UserRepository userRepository;

  GetAllUsersUseCase(this.userRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await userRepository.getAllUsers();
  }
}