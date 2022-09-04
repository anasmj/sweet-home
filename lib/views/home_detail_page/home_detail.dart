import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/dropdown_provider.dart';
import 'package:sweet_home/services/home_crud.dart';

import '../../models/home_model.dart';

class HomeDetail extends StatefulWidget {
  const HomeDetail({super.key});

  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  @override
  Widget build(BuildContext context) {
    DropdownProvider dropdownProvider = context.watch<DropdownProvider>();

    return Scaffold(
      body: FutureBuilder<Home?>(
        future: HomeCrud().getHome(homeId: dropdownProvider.currentHomeId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('দুঃক্ষিত,কোনও একটি সমস্যা হয়েছে');
          }

          if (snapshot.hasData) {
            Home home = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(home.homeName),
              ),
            );
          }
          return const Center(
            //waiting page
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
    // return FutureBuilder<Home?>(
    //   future: HomeCrud().getHome(homeId: dropdownProvider.currentHomeId),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       return const Text('দুঃক্ষিত,কোনও একটি সমস্যা হয়েছে');
    //     }

    //     if (snapshot.hasData) {
    //       Home home = snapshot.data!;

    //       return Scaffold(
    //         appBar: AppBar(
    //           centerTitle: true,
    //           title: Text(home.homeName),
    //         ),
    //       );
    //     }
    //     return const Center(
    //       //waiting page
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }
}
