import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/utils/user_flat.dart';

import '../models/home_model.dart';
import '../view/app_pages/flats_page/home_flats.dart';

//should return widget to show user
class FlatListVM extends ChangeNotifier {
  //make a list of flat
  late Widget displayWidget = Scaffold(
    body: Center(child: Text('loading..')),
  );

  Widget getFlatList(context) {
    Home? home = Provider.of<CurrentHomeProvider>(context).getCurrentHome;
    if (home == null) {
      return const Scaffold(
        body: Center(
          child: Text('No home yet'),
        ),
      );
    }
    //if there are no flats in home
    List<String> flatsName = UserFlats.getFlatList(
        floorRange: home.floor, flatRange: home.flatPerFloor);

    return HomeFlatsPage(flatNames: flatsName);
  }
}
