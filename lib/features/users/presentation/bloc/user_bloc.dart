import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:userdashboard/core/common/errors/failure.dart';
import 'package:userdashboard/core/common/usecase/usecase.dart';
import 'package:userdashboard/features/users/domain/entity/user_entity.dart';
import 'package:userdashboard/features/users/domain/usecase/get_all_users.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsersUseCase _getAllUsersUseCase;

  UserBloc({required GetAllUsersUseCase getAllUsersUseCase})
    : _getAllUsersUseCase = getAllUsersUseCase,
      super(UserInitial()) {
    on<RefreshUsersEvent>(_onRefreshUsersEvent);
  }

  FutureOr<void> _onRefreshUsersEvent(
    RefreshUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      final res = await _getAllUsersUseCase(NoParams());
      res.fold(
        (failure) => emit(UserErrorState(failure)),
        (users) => emit(UserLoadedState(users)),
      );
    } catch (e) {
      emit(UserErrorState(Failure(error: e.toString())));
    } finally {
      event.completer.complete();
    }
  }
}
