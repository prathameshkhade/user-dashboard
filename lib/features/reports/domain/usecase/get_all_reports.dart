
import 'package:fpdart/fpdart.dart';
import 'package:userdashboard/core/common/errors/failure.dart';
import 'package:userdashboard/core/common/usecase/usecase.dart';
import 'package:userdashboard/features/reports/data/repository/report_repository.dart';
import 'package:userdashboard/features/reports/domain/entity/report_entity.dart';

class GetAllReportsUseCase implements UseCase<List<ReportEntity>, NoParams> {
  final ReportRepository remoteRepository;

  GetAllReportsUseCase({required this.remoteRepository});

  @override
  Future<Either<Failure, List<ReportEntity>>> call(NoParams params) async {
    return await remoteRepository.getAllReports();
  }
}
