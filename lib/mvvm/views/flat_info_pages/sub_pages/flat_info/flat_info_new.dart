import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/views/flat_info_pages/sub_pages/flat_info/compnents/divider.dart';
import 'compnents/general_bill_list.dart';
import 'compnents/flat_info_list.dart';
import 'compnents/meter_reading_list.dart';
import 'compnents/save_button.dart';

class FlatInfoNew extends StatelessWidget {
  const FlatInfoNew({super.key});
  final double dividerHorizontalSpacing = 16;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 20),
        getDivider('বৈদ্যুতিক মিটার'),
        const MeterReadingList(),
        getDivider('বিল সমূহ'),
        const GeneralBillsList(),
        getDivider('ফ্ল্যাটের তথ্যাবলী'),
        const FlatInfoList(),
        const SaveButton(),
        const SizedBox(height: 40),
      ],
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
