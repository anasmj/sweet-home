import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';

import 'bill_tile.dart';

class FlatInfoList extends StatelessWidget {
  const FlatInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    Flat? flat = Provider.of<SelectedFlatProvider>(context).selectedFlat;

    return flat == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              BillTile(
                leadingIcon: Icons.bed,
                title: 'বেড ',
                subTitle: flat.noOfBed.toString(),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.remove)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add))
                  ],
                ),
              ),
              BillTile(
                leadingIcon: Icons.bathtub_outlined,
                title: 'বাথ ',
                subTitle: flat.bath.toString(),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.remove)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add))
                  ],
                ),
              ),
              BillTile(
                leadingIcon: Icons.camera_outdoor_outlined,
                title: 'বারান্দা ',
                subTitle: flat.varanda.toString(),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.remove)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add))
                  ],
                ),
              ),
              BillTile(
                leadingIcon: Icons.dining_outlined,
                title: 'ডাইনিং ',
                trailing: Switch.adaptive(
                  onChanged: (bool value) {},
                  value: flat.hasDiningRoom,
                ),
              ),
              BillTile(
                leadingIcon: Icons.chair,
                title: 'ড্রইং ',
                trailing: Switch.adaptive(
                  onChanged: (bool value) {},
                  value: flat.hasDrawingRoom,
                ),
              ),
            ],
          );
  }
}
