import 'package:flutter/material.dart';
import 'package:sweet_home/view/app_pages/home_detail_page/home_detail_page.dart';
import '../../models/home_model.dart';

// ignore: must_be_immutable
class HomeOptionsPage extends StatelessWidget {
  HomeOptionsPage({required this.userHomes, super.key});

  List<Home> userHomes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: userHomes
              .map((home) => makeListTile(context: context, home: home))
              .toList(),
        ));
  }

  Widget makeListTile({required BuildContext context, required Home home}) =>
      ListTile(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeDetail(home: home))),
        // onTap: () => HomeDetail(home: home),
        title: Text(home.homeName),
        subtitle: Text(home.location),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
        ),
      );
}
