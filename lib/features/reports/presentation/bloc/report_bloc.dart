import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:userdashboard/core/common/errors/failure.dart';
import 'package:userdashboard/core/common/usecase/usecase.dart';
import 'package:userdashboard/features/reports/domain/entity/report_entity.dart';
import 'package:userdashboard/features/reports/domain/usecase/get_all_reports.dart';

part 'report_event.dart';

part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetAllReportsUseCase _getAllReportsUseCase;

  ReportBloc(GetAllReportsUseCase getAllReportsUseCase)
    : _getAllReportsUseCase = getAllReportsUseCase,
      super(ReportInitial()) {
    on<NavigateToReportsEvent>(_onNavigateToCreateReportsEvent);
    on<FetchReportsEvent>(_onFetchReportsEvent);
  }

  FutureOr<void> _onNavigateToCreateReportsEvent(
    NavigateToReportsEvent _,
    Emitter<ReportState> emit,
  ) {
    emit(ReportNavigateToActionState());
  }

  FutureOr<void> _onFetchReportsEvent(
    FetchReportsEvent event,
    Emitter<ReportState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final res = await _getAllReportsUseCase(NoParams());
      res.fold(
        (failure) => emit(ReportsLoadingError(failure)),
        (reportsList) => emit(ReportsLoaded(reportsList)),
      );
    }
    finally {
      event.completer.complete();
    }
  }
}
