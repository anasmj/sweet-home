// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/utils/dialogs.dart';
import 'package:sweet_home/mvvm/view_models/renter_view_model.dart';
import '../../models/renter.dart';
import '../../view_models/add_renter_view_model.dart';
import '../../utils/formatter.dart';
import '../app_widgets.dart';
import 'components/profile_app_bar.dart';
import 'components/profile_textfield.dart';

// ignore: must_be_immutable
class RenterProfile extends StatefulWidget {
  RenterProfile({required this.renter, super.key});
  Renter renter;

  @override
  State<RenterProfile> createState() => _RenterProfileState();
}

class _RenterProfileState extends State<RenterProfile> {
  final double profileImageRadius = 60;

  final double containerHeight = 180;

  Widget entryDateStamp(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Theme.of(context).secondaryHeaderColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text(
              '${Formatter().monthYear(widget.renter.entryDate)} থেকে আছেন',
            ),
          ),
        ),
      ),
    );
  }

  void configureRenterInfo(AddRenterViewModel vm) {
    vm.renterNameController.text = widget.renter.renterName;
    vm.phoneController.text = widget.renter.phone;
    vm.altPhoneController.text = widget.renter.alternatePhoneNo ?? '';
    vm.previousLocationController.text = widget.renter.previousLocation ?? '';
    vm.villageController.text = widget.renter.village ?? '';
    vm.subDistrictController.text = widget.renter.subDistrict ?? '';
    vm.districtController.text = widget.renter.district ?? '';
    vm.occupationController.text = widget.renter.occupation ?? '';
    vm.noOfMemberController.text = widget.renter.numOfPerson.toString();
    vm.nIdController.text = widget.renter.nIdNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    final renterProvider = context.read<AddRenterViewModel>();
    configureRenterInfo(renterProvider);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const ProfileAppBar(),
            const SizedBox(height: 70),
            getSection(context, 'Personal Info'),
            const SizedBox(
              height: 10,
            ),
            MakeProfileTextField(
                title: 'নাম', controller: renterProvider.renterNameController),
            MakeProfileTextField(
              title: 'ফোন ',
              controller: renterProvider.phoneController,
              inputType: TextInputType.number,
            ),
            MakeProfileTextField(
              title: 'বিকল্প ফোন নম্বর',
              controller: renterProvider.altPhoneController,
              inputType: TextInputType.number,
            ),
            MakeProfileTextField(
                title: 'পেশা', controller: renterProvider.occupationController),
            MakeProfileTextField(
              title: 'সদস্য সংখ্যা',
              controller: renterProvider.noOfMemberController,
              inputType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: getSection(context, 'Residence'),
            ),
            MakeProfileTextField(
                title: 'পূর্বের ঠিকানা',
                controller: renterProvider.previousLocationController),
            MakeProfileTextField(
                title: 'গ্রাম', controller: renterProvider.villageController),
            MakeProfileTextField(
                title: 'উপজেলা',
                controller: renterProvider.subDistrictController),
            MakeProfileTextField(
                title: 'জেলা', controller: renterProvider.districtController),
            MakeProfileTextField(
                title: 'ভোটার আইডি কার্ড নম্বর',
                controller: renterProvider.districtController),
            entryDateStamp(context),
            TextButton(
              onPressed: () async {
                AppDialog().showLoadingDialog(
                    context: context, msg: 'গ্রাহক মুছে ফেলা হচ্ছে . .');

                Response res = await context
                    .read<RenterViewModel>()
                    .removeRenterFromFlat();

                Navigator.pop(context); // remove dialog
                Navigator.pop(context); //pop renter profile page
                Navigator.pop(context); //pop month detail page
                if (res.code != 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${res.body}')));
                } else {
                  AppWidget.showToast('ফ্ল্যাটটি খালি করা হয়েছে');
                }
              },
              child: const Text(
                'গ্রাহক মুছে ফেলুন',
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

Container getSection(BuildContext context, String title) {
  return Container(
    color: Colors.grey.withOpacity(0.2),
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.grey),
      ),
    ),
  );
}
