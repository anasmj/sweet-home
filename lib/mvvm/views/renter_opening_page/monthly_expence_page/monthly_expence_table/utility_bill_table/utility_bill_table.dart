import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/utility.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/home_service_charge_view_model.dart';

// ignore: must_be_immutable
class UtilityTable extends StatelessWidget {
  UtilityTable({
    super.key,
    this.viewModel,
  });
  List<Utility>? othersList;
  HomeServiceChargeListViewModel? viewModel;
  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      if (!viewModel!.isLoading) {
        return SizedBox(
          width: 200,
          child: Column(
            children:
                viewModel!.serviceChargeList.map((e) => buildRow(e)).toList(),
          ),
        );
      } else {
        return const CircularProgressIndicator();
      }
    }
    return const SizedBox.shrink();
  }

  Widget buildRow(Utility obj) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(obj.purpose),
          Text(Formatter.toBn(value: obj.amount)),
        ],
      );
}
