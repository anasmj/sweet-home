import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';

import '../../../models/flat_model.dart';
import 'compnents/flat_info_list.dart';

class SingleFlatInfo extends StatelessWidget {
  const SingleFlatInfo({super.key});
  @override
  Widget build(BuildContext context) {
    Flat? flat = context.read<SelectedFlatProvider>().selectedFlat;
    return flat == null
        ? const SizedBox()
        : DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(flat.flatName),
                centerTitle: true,
                elevation: 0.0,
                bottom: TabBar(
                  labelStyle: Theme.of(context).textTheme.subtitle1,
                  indicatorColor: Colors.white,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(
                      text: 'ফ্ল্যাটের তথ্যাবলী',
                    ),
                    Tab(
                      text: 'পূর্বের রেকর্ড',
                      // style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  // const Center(child: Text('Monthly Expence')),
                  FlatInfoList(),
                  const Center(child: Text('flat history')),
                ],
              ),
            ),
          );
  }
}
