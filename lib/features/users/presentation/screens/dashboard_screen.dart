import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdashboard/features/reports/presentation/bloc/report_bloc.dart';
import 'package:userdashboard/features/users/domain/entity/user_entity.dart';
import 'package:userdashboard/features/users/presentation/bloc/user_bloc.dart';
import 'package:userdashboard/features/users/presentation/screens/user_form_screen.dart';
import 'package:userdashboard/features/users/presentation/screens/user_profile.dart';
import 'package:userdashboard/features/users/presentation/widgets/user_tile.dart';

import '../../../reports/presentation/screens/reports_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final searchController = TextEditingController();
  List<UserEntity> users = [];
  List<UserEntity> originalUsers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  Future<void> loadUsers() {
    final completer = Completer<void>();
    context.read<UserBloc>().add(RefreshUsersEvent(completer: completer));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: <IconButton>[
          IconButton(
            icon: Icon(CupertinoIcons.add),
            onPressed: () {
              context.read<UserBloc>().add(
                NavigateToScreenEvent(UserFormScreen()),
              );
            },
          ),
        ],
      ),

      body: BlocConsumer<UserBloc, UserState>(
        buildWhen: (previous, current) => current is! UserActionState,
        listenWhen: (previous, current) => current is UserActionState,
        listener: (context, state) {
          if (state is NavigateToScreenActionState) {
            Navigator.push(context, state.route);
          }
          else if (state is ReportNavigateToActionState) {
            Navigator.push(context, ReportsScreen.route());
          }
        },
        builder: (context, state) {
          if (state is UserErrorState) {
            return Center(
              child: Text(
                'Error: ${state.failure.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is UserLoadedState) {
            users = state.users;
            originalUsers = state.originalUsers;
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: loadUsers,
              child: ListView(
                children: [
                  // Search bar
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.colorScheme.inverseSurface.withValues(
                        alpha: 0.1,
                      ),
                    ),
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                        hintText: 'Search Users',
                      ),
                      onChanged: (value) {
                        context.read<UserBloc>().add(
                          SearchUsersEvent(query: value),
                        );
                      },
                    ),
                  ),

                  // Sorting buttons
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<UserBloc>().add(
                              SortUsersEvent(ascending: true),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: theme.colorScheme.outline.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              'Sort A-Z',
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            context.read<UserBloc>().add(
                              SortUsersEvent(ascending: false),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: theme.colorScheme.outline.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              'Sort Z-A',
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // List of Users
                  ...users.map(
                        (user) => UserTile(
                      user: user,
                      onTap: () {
                        context.read<UserBloc>().add(
                          NavigateToScreenEvent(
                            UserProfile(user: user),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: loadUsers,
            child: ListView(
              // Use ListView to allow RefreshIndicator to work even when child is empty
              children: const [SizedBox.shrink()],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.primaryColor,
        icon: Icon(
          CupertinoIcons.doc_text,
          color: theme.colorScheme.inverseSurface,
        ),
        label: Text(
          'Reports',
          style: TextStyle(
            color: theme.colorScheme.inverseSurface,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => Navigator.push(context, ReportsScreen.route()),
      ),
    );
  }
}