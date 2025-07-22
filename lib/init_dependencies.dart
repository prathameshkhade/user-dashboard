import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:userdashboard/features/users/data/datasource/remote_data_source.dart';
import 'package:userdashboard/features/users/data/datasource/remote_data_source_impl.dart';
import 'package:userdashboard/features/users/data/repository/user_repository_impl.dart';
import 'package:userdashboard/features/users/domain/repository/user_repository.dart';
import 'package:userdashboard/features/users/domain/usecase/get_all_users.dart';
import 'package:userdashboard/features/users/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  initUsers();

  sl.registerLazySingleton(() => http.Client());
}

void initUsers() {
  // Data sources
  sl.registerFactory<RemoteDataSource>(() => RemoteDataSourceImpl(sl()));

  // Repositories
  sl.registerFactory<UserRepository>(() => UserRepositoryImpl(sl()));

  // Use cases
  sl.registerFactory(() => GetAllUsersUseCase(sl()));
  
  // bloc
  sl.registerLazySingleton<UserBloc>(() => UserBloc(getAllUsersUseCase: sl()));
}