import 'package:sweet_home/prev/models/app_user.dart';
import 'package:sweet_home/mvvm/models/record.dart';

class Response {
  int? code;
  String? body;
  AppUser? user;
  Record? monthlyRecord;
  dynamic content;
  Response({this.code, this.body, this.user, this.monthlyRecord});
}
