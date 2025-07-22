import 'package:userdashboard/features/users/data/model/user_model.dart';

abstract interface class RemoteDataSource {
  Future<List<UserModel>> getAllUsers();
}