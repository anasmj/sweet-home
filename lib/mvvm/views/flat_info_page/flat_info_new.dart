import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/home_model.dart';
import 'package:sweet_home/mvvm/views/flat_info_page/compnents/divider.dart';
import '../../view_models/selected_flat_view_model.dart';
import 'compnents/general_bill_list.dart';
import 'compnents/meter_reading_list.dart';

// ignore: must_be_immutable
class FlatInfoNew extends StatelessWidget {
  FlatInfoNew({super.key, this.flat, this.home});
  final double dividerHorizontalSpacing = 16;
  Flat? flat;
  Home? home;
  @override
  Widget build(BuildContext context) {
    Flat? flat = Provider.of<SelectedFlatVuewModel>(context).selectedFlat;

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          flat == null ? const SizedBox.shrink() : const MeterReadingList(),
          getDivider('বিল সমূহ'),
          GeneralBillsList(
            flat: flat,
          ),
          // getDivider('ফ্ল্যাটের তথ্যাবলী'),
          // const FlatInfoList(),
          // InfoSaveButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Padding getDivider(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dividerHorizontalSpacing),
      child: FlatInfoDIvider(
        title: title,
      ),
    );
  }
}
