import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rent_home/models/flat_model.dart';
import 'package:rent_home/providers/home_provider.dart';

import '../../../../../providers/newrenter_step_provider.dart';
import '../../../../app_widgets.dart';

class FlatChoicieChips extends StatefulWidget {
  const FlatChoicieChips({super.key});
  @override
  State<FlatChoicieChips> createState() => _FlatChoicieChipsState();
}

class _FlatChoicieChipsState extends State<FlatChoicieChips> {
  int? _chosenByUser;
  bool selected = false;

  final Color _occupiedFlatChoiceChipColor = Colors.green.withOpacity(.20);
  final Color _occupiedFlatSelectedColor = Colors.green.withOpacity(.40);
  final Color _emptyFlatSelectedColor = Colors.red.withOpacity(.40);
  final Color _occupiedFlatCircleAvatarColor = Colors.green.withOpacity(0.6);
  final Color _emptyFaltCircleAvatarColor = Colors.red.withOpacity(0.8);
  final Color _flatNameColor = Colors.white;
  final Color _emptyFlatChoiceChipColor = Colors.red.withOpacity(.20);

  @override
  Widget build(BuildContext context) {
    List<Flat> flatList = Provider.of<HomeProvider>(context).flats;
    final provider = Provider.of<NewRenterStepProvider>(context);
    provider.selectedFlatNo = _chosenByUser;

    return SingleChildScrollView(
      child: Wrap(
        spacing: 10,
        runSpacing: 6,
        children: List.generate(
          flatList.length,
          (flatNo) => ChoiceChip(
            elevation: 4,
            backgroundColor: flatList[flatNo].renter != null
                ? _occupiedFlatChoiceChipColor
                : _emptyFlatChoiceChipColor,
            labelStyle: Theme.of(context).textTheme.subtitle1,
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            label: flatList[flatNo].renter != null
                ? Text(flatList[flatNo].renter!.name)
                : const Text('খালি আছে'),
            avatar: CircleAvatar(
              backgroundColor: flatList[flatNo].renter != null
                  ? _occupiedFlatCircleAvatarColor
                  : _emptyFaltCircleAvatarColor,
              radius: 14,
              child: Text(
                flatList[flatNo].flatName,
                style: TextStyle(
                  color: _flatNameColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            selected: _chosenByUser == flatNo,
            // selected: _chosenByUser == flatNo,
            onSelected: ((bool selected) {
              setState(
                () {
                  _chosenByUser = selected &&
                          flatList[flatNo].renter ==
                              null //cant be selected where already a rente
                      ? flatNo
                      : null;
                },
              );
              if (selected && flatList[flatNo].renter != null) {
                AppWidget.showToast("ফ্ল্যাটটি খালি নেই");
              }
            }),
            selectedColor: flatList[flatNo].renter != null
                ? _occupiedFlatSelectedColor
                : _emptyFlatSelectedColor,
          ),
        ),
      ),
    );
  }
}
