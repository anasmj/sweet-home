import 'package:flutter/cupertino.dart';

class HomeSummary extends ChangeNotifier {
  String? homeId;
  String? homeName;
  HomeSummary({this.homeId, this.homeName});
  static HomeSummary fromJson(Map<String, dynamic> json) => HomeSummary(
        homeId: json['Home Id'],
        homeName: json['Home Name'],
      );
}
