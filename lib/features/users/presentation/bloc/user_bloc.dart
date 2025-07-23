import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:userdashboard/core/common/errors/failure.dart';
import 'package:userdashboard/core/common/usecase/usecase.dart';
import 'package:userdashboard/features/users/domain/entity/user_entity.dart';
import 'package:userdashboard/features/users/domain/usecase/get_all_users.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsersUseCase _getAllUsersUseCase;
  List<UserEntity> _originalUsers = []; // Keep track of original unfiltered list
  String _currentSearchQuery = '';
  SortType _currentSortType = SortType.none;

  UserBloc({required GetAllUsersUseCase getAllUsersUseCase})
      : _getAllUsersUseCase = getAllUsersUseCase,
        super(UserInitial()) {
    on<RefreshUsersEvent>(_onRefreshUsersEvent);
    on<SearchUsersEvent>(_onSearchUsersEvent);
    on<NavigateToScreenEvent>(_onNavigateToUserFormEvent);
    on<SortUsersEvent>(_onSortUsersEvent);
  }

  FutureOr<void> _onRefreshUsersEvent(
      RefreshUsersEvent event,
      Emitter<UserState> emit,
      ) async {
    try {
      final res = await _getAllUsersUseCase(NoParams());
      res.fold(
            (failure) => emit(UserErrorState(failure)),
            (users) {
          _originalUsers = users;
          _currentSearchQuery = '';
          _currentSortType = SortType.none;
          emit(UserLoadedState(users, _originalUsers, _currentSortType));
        },
      );
    } catch (e) {
      emit(UserErrorState(Failure(error: e.toString())));
    } finally {
      event.completer.complete();
    }
  }

  FutureOr<void> _onNavigateToUserFormEvent(
      NavigateToScreenEvent event,
      Emitter<UserState> emit,
      ) {
    emit(
      NavigateToScreenActionState(
        CupertinoPageRoute(builder: (context) => event.destination),
      ),
    );
  }

  FutureOr<void> _onSearchUsersEvent(
      SearchUsersEvent event,
      Emitter<UserState> emit,
      ) {
    _currentSearchQuery = event.query.toLowerCase();
    debugPrint('Search query: $_currentSearchQuery');

    List<UserEntity> filteredUsers;
    if (_currentSearchQuery.isEmpty) {
      filteredUsers = List.from(_originalUsers);
    } else {
      filteredUsers = _originalUsers.where(
            (user) => user.name.toString().toLowerCase().contains(_currentSearchQuery),
      ).toList();
    }

    // Apply current sorting
    _applySorting(filteredUsers);

    emit(UserLoadedState(filteredUsers, _originalUsers, _currentSortType));
  }

  FutureOr<void> _onSortUsersEvent(
      SortUsersEvent event,
      Emitter<UserState> emit,
      ) {
    // Toggle sort: if same sort type is clicked, remove sorting
    if (_currentSortType == event.sortType) {
      _currentSortType = SortType.none;
    } else {
      _currentSortType = event.sortType;
    }

    // Get current filtered users or original users
    List<UserEntity> usersToSort;
    if (_currentSearchQuery.isEmpty) {
      usersToSort = List.from(_originalUsers);
    } else {
      usersToSort = _originalUsers.where(
            (user) => user.name.toString().toLowerCase().contains(_currentSearchQuery),
      ).toList();
    }

    _applySorting(usersToSort);

    emit(UserLoadedState(usersToSort, _originalUsers, _currentSortType));
  }

  void _applySorting(List<UserEntity> users) {
    if (_currentSortType == SortType.none) return;

    users.sort((a, b) {
      final comparison = a.name.toString().toLowerCase().compareTo(b.name.toString().toLowerCase());
      return _currentSortType == SortType.ascending ? comparison : -comparison;
    });
  }
}