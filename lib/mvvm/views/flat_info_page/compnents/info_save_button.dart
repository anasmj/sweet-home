import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';

// ignore: must_be_immutable
class InfoSaveButton extends StatelessWidget {
  InfoSaveButton({super.key});

  bool hasChanged = false;

  SelectedFlatProvider? provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SelectedFlatProvider>(context);
    // if (provider!.selectedFlat != null) {
    //   hasChanged = provider?.selectedFlat!.noOfBed != provider?.noOfBed ||
    //       provider?.selectedFlat!.bath != provider?.bath ||
    //       provider?.selectedFlat!.varanda != provider?.varanda ||
    //       provider?.selectedFlat!.hasDiningRoom != provider?.hasDining ||
    //       provider?.selectedFlat!.hasDrawingRoom != provider?.hasDrawing;
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: hasChanged ? () {} : null,
        child: const Text(
          'সেভ',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
