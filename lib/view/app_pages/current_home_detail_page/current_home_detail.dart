import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/current_home.dart';

import '../../../models/home_model.dart';
import '../../../services/database_service/home_crud.dart';
import 'components/home_detail_content.dart';

class CurrentHomeDetail extends StatefulWidget {
  CurrentHomeDetail({super.key});
  @override
  State<CurrentHomeDetail> createState() => _UserHomeDetailState();
}

class _UserHomeDetailState extends State<CurrentHomeDetail> {
  @override
  Widget build(BuildContext context) {
    CurrentHomeProvider dropdownProvider = context.watch<CurrentHomeProvider>();

    return Scaffold(
      body: FutureBuilder<Home?>(
        future: HomeCrud().getHomeById(homeId: dropdownProvider.currentHomeId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('দুঃক্ষিত,কোনও একটি সমস্যা হয়েছে');
          }
          if (snapshot.hasData) {
            Home home = snapshot.data!;
            return HomeDetailContent(home: home);
          }
          return const Center(
            //waiting page
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
