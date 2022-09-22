import 'package:sweet_home/models/app_user.dart';
import 'package:sweet_home/models/monthly_record.dart';

class Response {
  int? code;
  String? body;
  AppUser? user;
  MonthlyRecord? monthlyRecord;
  Response({this.code, this.body, this.user, this.monthlyRecord});
}
