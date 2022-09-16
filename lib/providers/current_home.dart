import 'package:flutter/cupertino.dart';
import 'package:sweet_home/models/home_model.dart';

class CurrentHomeProvider extends ChangeNotifier {
  Home? _currentHome;
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  TextEditingController displayTextController = TextEditingController();

  Home? get currentHome => _currentHome;

  void setCurrentHome(Home? selectedHome) {
    _currentHome = selectedHome;
    // notifyListeners(); //?should it be ?
  }
}
