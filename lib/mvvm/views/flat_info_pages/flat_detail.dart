import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/views/flat_info_pages/sub_pages/flat_info/flat_info_new.dart';

import '../../models/flat_model.dart';
import '../../providers/selected_flat_view_model.dart';
import 'sub_pages/flat_info/flat_info.dart';

class SingleFlatInfo extends StatelessWidget {
  const SingleFlatInfo({super.key});
  @override
  Widget build(BuildContext context) {
    Flat? flat = context.read<SelectedFlatVuewModel>().selectedFlat;
    return flat == null
        ? const SizedBox()
        : DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text('ফ্ল্যাটঃ ${flat.flatName}'),
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
                  FlatInfo(),
                  const FlatInfoNew()
                  // const Center(child: Text('flat history')),
                ],
              ),
            ),
          );
  }
}
