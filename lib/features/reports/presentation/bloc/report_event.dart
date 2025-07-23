part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

class FetchReportsEvent extends ReportEvent {
  final Completer completer;
  FetchReportsEvent(this.completer);
}

class NavigateToReportsEvent extends ReportEvent {}
