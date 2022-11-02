import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/views/flat_info_page/selected_flat_bills.dart';
import '../../models/flat_model.dart';
import '../../providers/selected_flat_provider.dart';

class SelectedFlatDetail extends StatelessWidget {
  const SelectedFlatDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Flat? flat = context.watch<SelectedFlatProvider>().selectedFlat;
    return flat == null
        ? const Scaffold(body: Center(child: Text('test')))
        : DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: Text('ফ্ল্যাটঃ ${flat.flatName}'),
                centerTitle: true,
                elevation: 0.0,
                bottom: TabBar(
                  labelStyle: Theme.of(context).textTheme.titleMedium,
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
                  const SelectedFlatBills(),
                  Container(),
                ],
              ),
            ),
          );
  }
}
