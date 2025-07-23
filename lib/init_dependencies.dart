import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:userdashboard/features/reports/domain/usecase/get_all_reports.dart';
import 'package:userdashboard/features/reports/presentation/bloc/report_bloc.dart';
import 'package:userdashboard/features/users/data/datasource/remote_data_source.dart';
import 'package:userdashboard/features/users/data/datasource/remote_data_source_impl.dart';
import 'package:userdashboard/features/users/data/repository/user_repository_impl.dart';
import 'package:userdashboard/features/users/domain/repository/user_repository.dart';
import 'package:userdashboard/features/users/domain/usecase/get_all_users.dart';
import 'package:userdashboard/features/users/presentation/bloc/user_bloc.dart';

import 'features/reports/data/repository/report_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  initUsers();
  initReports();

  sl.registerLazySingleton(() => http.Client());
}

void initReports() {
  // Repositories
  sl.registerFactory(() => ReportRepository());

  // Use case
  sl.registerFactory(() => GetAllReportsUseCase(remoteRepository: sl()));

  // Report bloc
  sl.registerLazySingleton<ReportBloc>(() => ReportBloc(sl()));
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