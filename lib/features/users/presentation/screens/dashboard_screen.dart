import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdashboard/features/users/presentation/bloc/user_bloc.dart';
import 'package:userdashboard/features/users/presentation/screens/user_form_screen.dart';
import 'package:userdashboard/features/users/presentation/widgets/user_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  Future<void> loadUsers() async {
    final completer = Completer<void>();
    context.read<UserBloc>().add(RefreshUsersEvent(completer: completer));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
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
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: loadUsers,
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) =>
                    UserTile(user: state.users[index]),
              ),
            );
          }

          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: loadUsers,
            child: const Center(child: Text('Loading...')),
          );
        },
      ),
    );
  }
}
