import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/view_models/selected_flat_view_model.dart';

import 'bill_tile.dart';

class FlatInfoList extends StatelessWidget {
  const FlatInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    SelectedFlatVuewModel provider =
        Provider.of<SelectedFlatVuewModel>(context);

    return provider.selectedFlat == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              BillTile(
                leadingIcon: Icons.bed,
                title: 'বেড ',
                subTitle: provider.noOfBed.toString(),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          provider.changeNoOfBed(shouldIncrease: false);
                        },
                        icon: const Icon(Icons.remove)),
                    IconButton(
                        onPressed: () {
                          provider.changeNoOfBed(shouldIncrease: true);
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
              ),
              BillTile(
                leadingIcon: Icons.bathtub_outlined,
                title: 'বাথ ',
                subTitle: provider.bath.toString(),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          provider.changeBath(shouldIncrease: false);
                        },
                        icon: const Icon(Icons.remove)),
                    IconButton(
                        onPressed: () {
                          provider.changeBath(shouldIncrease: true);
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
              ),
              BillTile(
                leadingIcon: Icons.camera_outdoor_outlined,
                title: 'বারান্দা ',
                subTitle: provider.varanda.toString(),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          provider.changeVaranda(shouldIncrease: false);
                        },
                        icon: const Icon(Icons.remove)),
                    IconButton(
                        onPressed: () {
                          provider.changeVaranda(shouldIncrease: true);
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
              ),
              BillTile(
                leadingIcon: Icons.dining_outlined,
                title: 'ডাইনিং ',
                trailing: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  value: provider.hasDining,
                  onChanged: (value) => provider.changeDining(value!),
                ),
              ),
              BillTile(
                leadingIcon: Icons.chair,
                title: 'ড্রইং ',
                trailing: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  value: provider.hasDrawing,
                  onChanged: (value) => provider.changeDrawing(value!),
                ),
              ),
            ],
          );
  }
}
