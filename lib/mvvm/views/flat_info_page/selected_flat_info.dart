import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/views/error_pages/error_page.dart';
import 'package:sweet_home/mvvm/views/flat_info_page/compnents/divider.dart';
import '../../providers/selected_flat_provider.dart';
import 'compnents/general_bill_list.dart';
import 'compnents/meter_reading_list.dart';

// ignore: must_be_immutable
class SelectedFlatInfo extends StatelessWidget {
  const SelectedFlatInfo({super.key});
  final double dividerHorizontalSpacing = 16;
  @override
  Widget build(BuildContext context) {
    String? selectedFlat =
        context.watch<SelectedFlatProvider>().selectedFlat?.flatName;
    String? homeId =
        Provider.of<CurrentHomeProvider>(context).currentHome?.homeId;
    if (selectedFlat == null || homeId == null) return const ErrorPage();
    return StreamBuilder<Flat>(
      stream: FlatService()
          .selectedFlatSteram(homeId: homeId, flatId: selectedFlat),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const ErrorPage();
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          Flat? flat = snapshot.data;
          if (flat == null) return const ErrorPage();
          return optionList(flat);
        }
        return const SizedBox.shrink();
      },
    );
  }

  ListView optionList(Flat flat) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        flat.renter != null
            ? MeterReadingList(flat: flat)
            : const SizedBox.shrink(),
        getDivider('বিল সমূহ'),
        GeneralBillsList(flat: flat),
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
