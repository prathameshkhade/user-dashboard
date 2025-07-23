import 'package:fpdart/fpdart.dart';
import 'package:userdashboard/core/common/errors/failure.dart';
import 'package:userdashboard/features/reports/data/datasource/reports_data_source.dart';
import 'package:userdashboard/features/reports/data/model/report_model.dart';

class ReportRepository {
  ReportRepository();

  Future<Either<Failure, List<ReportModel>>> getAllReports() async {
    try {
      return Either.right(ReportDataSource.fakeReports);
    }
    catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
