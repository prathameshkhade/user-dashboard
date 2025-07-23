import 'package:flutter/material.dart';
import 'package:userdashboard/features/reports/domain/entity/report_entity.dart';

class ReportsTile extends StatelessWidget {
  final ReportEntity report;

  const ReportsTile({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              report.imageUrl,
              width: 130,
              height: 132,
              fit: BoxFit.cover,
            ),
          ),

          // Report Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Report #{id}
                Text(
                  'Report #${report.id}',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                // Report Title
                Text(
                  report.title,
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(height: 4),

                // Report Summery
                Text(
                  report.summery,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
