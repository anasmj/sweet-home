import 'package:sweet_home/models/app_user.dart';

class Response {
  int? code;
  String? body;
  AppUser? user;
  Response({this.code, this.body, this.user});
}
