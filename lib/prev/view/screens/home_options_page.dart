import 'package:flutter/material.dart';
import '../../models/home_model.dart';
import '../../utils/routes.dart';
import 'home_info_page/home_info_page.dart';

// ignore: must_be_immutable
class HomeOptionsPage extends StatelessWidget {
  HomeOptionsPage({required this.userHomes, super.key});
  final String addNewHome = 'বাড়ী যুক্ত';
  List<Home> userHomes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => AppRoute.newHomeStepper(context: context),
                icon: const Icon(Icons.add)),
          ],
        ),
        body: ListView(
          children: userHomes
              .map((home) => makeListTile(context: context, home: home))
              .toList(),
        ));
  }

  Widget makeListTile({required BuildContext context, required Home home}) =>
      ListTile(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeInfoPage(home: home))),
        // onTap: () => HomeDetail(home: home),
        title: Text(home.homeName),
        subtitle: Text(home.location),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
        ),
      );
}
