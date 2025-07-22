import 'dart:async';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:userdashboard/features/users/data/datasource/remote_data_source.dart';
import 'package:userdashboard/features/users/domain/entity/user_entity.dart';
import 'package:userdashboard/features/users/domain/repository/user_repository.dart';

import '../../../../core/common/errors/failure.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final users = await remoteDataSource.getAllUsers();
      return right(users);
    }
    on SocketException {
      return left(Failure(error: 'No internet connection'));
    }
    on TimeoutException {
      return left(Failure(error: 'Request timeout'));
    }
    catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}