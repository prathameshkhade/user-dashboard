import 'package:userdashboard/features/reports/data/model/report_model.dart';

class ReportDataSource {
  static List<ReportModel> fakeReports = [
    ReportModel(
      1,
      'assets/images/monthly_sales_report.png',
      'Monthly Sales Report',
      'Sales increased by 15% compared to the previous month.',
    ),
    ReportModel(
      2,
      'assets/images/customer_satisfaction.png',
      'Customer Satisfaction Survey',
      'Overall satisfaction rating is 4.5 out of 5, with positive feedback on product quality.',
    ),
    ReportModel(
      3,
      'assets/images/marketing_campaign_performance.png',
      'Making Campaign Perform',
      'The latest campaign reached 200,000 users, with a 5% conversion fee.',
    ),
  ];
}
