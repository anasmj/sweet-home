// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sweet_home/src/model/renter.dart';

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
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text(
              // '${Formatter().monthYear(widget.renter.entryDate)} থেকে আছেন',
              '12 থেকে আছেন',
            ),
          ),
        ),
      ),
    );
  }

  // void configureRenterInfo(AddRenterViewModel vm) {
  //   vm.renterNameController.text = widget.renter.renterName;
  //   vm.phoneController.text = widget.renter.phone;
  //   vm.altPhoneController.text = widget.renter.alternatePhoneNo ?? '';
  //   vm.previousLocationController.text = widget.renter.previousLocation ?? '';
  //   vm.villageController.text = widget.renter.village ?? '';
  //   vm.subDistrictController.text = widget.renter.subDistrict ?? '';
  //   vm.districtController.text = widget.renter.district ?? '';
  //   vm.occupationController.text = widget.renter.occupation ?? '';
  //   vm.noOfMemberController.text = widget.renter.numOfPerson.toString();
  //   vm.nIdController.text = widget.renter.nIdNumber.toString();
  // }

  @override
  Widget build(BuildContext context) {
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
              title: 'নাম',
            ),
            MakeProfileTextField(
              title: 'ফোন ',
              inputType: TextInputType.number,
            ),
            MakeProfileTextField(
              title: 'বিকল্প ফোন নম্বর',
              inputType: TextInputType.number,
            ),
            MakeProfileTextField(
              title: 'পেশা',
            ),
            MakeProfileTextField(
              title: 'সদস্য সংখ্যা',
              inputType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: getSection(context, 'Residence'),
            ),
            MakeProfileTextField(
              title: 'পূর্বের ঠিকানা',
            ),
            MakeProfileTextField(
              title: 'গ্রাম',
            ),
            MakeProfileTextField(
              title: 'উপজেলা',
            ),
            MakeProfileTextField(
              title: 'জেলা',
            ),
            MakeProfileTextField(
              title: 'ভোটার আইডি কার্ড নম্বর',
            ),
            entryDateStamp(context),
            TextButton(
              onPressed: () async {
                // AppDialog().showLoadingDialog(
                //     context: context, msg: 'গ্রাহক মুছে ফেলা হচ্ছে . .');

                // Navigator.pop(context); // remove dialog
                // Navigator.pop(context); //pop renter profile page
                // Navigator.pop(context); //pop month detail page
                // if (res.code != 200) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('Error: ${res.body}')));
                // } else {
                //   AppWidget.showToast('ফ্ল্যাটটি খালি করা হয়েছে');
                // }
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
