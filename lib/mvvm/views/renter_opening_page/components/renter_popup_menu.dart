import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/views/flat_info_page/selected_flat_detail.dart';
import 'package:sweet_home/mvvm/views/profile_pages/renter_profile_page.dart';

// ignore: must_be_immutable
class RenterPopUpMenu extends StatelessWidget {
  RenterPopUpMenu({required this.flat, super.key});
  Flat flat;
  List<String> menuTitles = [
    'ফ্ল্যাটের তথ্যাবলী',
    'গ্রাহকের প্রোফাইল',
    'তাগাদা দিন'
  ];
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return menuTitles
            .map((title) => PopupMenuItem(
                  value: title,
                  child: Text(title),
                ))
            .toList();
      },
      onSelected: (value) {
        switch (value) {
          case 'গ্রাহকের প্রোফাইল':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RenterProfile(
                  renter: flat.renter!,
                ),
              ),
            );
            break;
          case 'ফ্ল্যাটের তথ্যাবলী':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectedFlatDetail(),
              ),
            );

            break;
          case 'তাগাদা দিন':
            break;
        }
      },
    );
  }
}
