part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

class FetchReportsEvent extends ReportEvent {}

class NavigateToReportsEvent extends ReportEvent {}
