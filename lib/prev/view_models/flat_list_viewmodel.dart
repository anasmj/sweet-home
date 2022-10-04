// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/flat_model.dart';
// import '../models/home_model.dart';
// import '../../mvvm/providers/current_home.dart';
// import '../services/flat_services.dart';
// import '../view/screens/loading_widget.dart';

// //2nd try with enum
// enum LoadingStatus { completed, searching, empty }

// //! convert to view model later
// class FlatListViweModel extends ChangeNotifier {
//   FlatListViweModel() {
//     getFlatListFromDB();
//   }
//   Home? currentUserHome = CurrentHaomeProvider()
//       .currentHome; //! always getting null somehow, fix later
//   LoadingStatus status = LoadingStatus.empty;
//   bool _isLoading = false;
//   List<Flat> _flatListModel = [];

//   bool get loading => _isLoading;
//   setLoading(bool laoding) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   get flatListModel => _flatListModel;
//   setFlatListModel(List<Flat> flatList) {
//     _flatListModel = flatList;
//   }

//   void getFlatListFromDB() async {
//     if (currentUserHome != null) {
//       setLoading(true);
//       status = LoadingStatus.searching;
//       // List<Flat> flatList =
//       //     await FlatService().getAllFlats(homeId: currentUserHome!.homeId);
//       // if (flatList.isNotEmpty) {
//       //   status = LoadingStatus.completed;
//       // }
//       setLoading(false);
//     }
//     if (currentUserHome == null) {
//       print('home null');
//     }
//   }
// }
