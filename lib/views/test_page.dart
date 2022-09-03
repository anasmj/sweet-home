import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/home_summary.dart';
import '../../../providers/theme_provider.dart';
import '../../../services/home_crud.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeProvider>();

    return Scaffold(
      body: FutureBuilder<List<HomeSummary>?>(
        future: HomeCrud().getHOmes(),
        builder: (context, AsyncSnapshot<List<HomeSummary>?> snapshot) {
          if (snapshot.hasData) {
            final homes = snapshot.data;
            print(homes![0]);
            return ListView(
              children: homes.map((home) {
                return Text(home.homeName ?? 'no name ');
              }).toList(),
            );
          }
          return Text('has no data ');
        },
      ),
    );
  }
}
