import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/report_bloc.dart';
import '../widgets/reports_tile.dart';

class ReportsScreen extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (context) => ReportsScreen());

  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  Future<void> loadReports() async {
    final completer = Completer<void>();
    context.read<ReportBloc>().add(FetchReportsEvent(completer));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        // titleTextStyle: theme.textTheme.headlineSmall,
        title: const Text('Reports'),
      ),

      body: BlocConsumer<ReportBloc, ReportState>(
        buildWhen: (previous, current) => current is! ReportActionState,
        listenWhen: (previous, current) => current is ReportActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ReportsLoadingError) {
            return Center(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: loadReports,
                child: Text(state.failure.error, textAlign: TextAlign.center)
              ),
            );
          }
          else if (state is ReportsLoaded) {
            final reports = state.reports;
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: loadReports,
              child: ListView.separated(
                itemCount: reports.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) => ReportsTile(report: reports[index]),
              ),
            );
          }

          // Default view
          return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: loadReports,
              child: const SizedBox.shrink()
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.primaryColor,
        icon: Icon(CupertinoIcons.add, color: theme.colorScheme.inverseSurface),
        label: Text(
          'New Report',
          style: TextStyle(
            color: theme.colorScheme.inverseSurface,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: const Text('Not Implemented yet'))
            );
        },
      ),
    );
  }
}
