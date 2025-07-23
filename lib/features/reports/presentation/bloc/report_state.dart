part of 'report_bloc.dart';

@immutable
sealed class ReportState {}
sealed class ReportActionState extends ReportState {}

final class ReportInitial extends ReportState {}

class ReportsLoaded extends ReportState {
  final List<ReportEntity> reports;
  ReportsLoaded(this.reports);
}

class ReportsLoadingError extends ReportState {
  final Failure failure;
  ReportsLoadingError(this.failure);
}

class ReportNavigateToActionState extends ReportActionState {}