import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/repositories/renter_service.dart';

import '../../models/renter.dart';
import '../../providers/current_home.dart';
import '../../providers/selected_flat_provider.dart';
import '../../../prev/providers/newrenter_step_provider.dart';
import '../../utils/custom_date_time_formatter.dart';
import '../app_widgets.dart';
import 'components/profile_app_bar.dart';
import 'components/profile_textfield.dart';

// ignore: must_be_immutable
class RenterProfile extends StatelessWidget {
  RenterProfile({required this.renter, super.key});
  Renter renter;
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
              '${CustomFormatter().monthYear(renter.entryDate!)} থেকে আছেন',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final renterProvider = context.read<NewRenterStepProvider>();
    renterProvider.renterNameController.text = renter.renterName;
    renterProvider.phoneController.text = renter.phoneNo;
    renterProvider.altPhoneController.text = renter.alternatePhoneNo ?? '';
    renterProvider.previousLocationController.text =
        renter.previousLocation ?? '';
    renterProvider.villageController.text = renter.village ?? '';
    renterProvider.subDistrictController.text = renter.subDistrict ?? '';
    renterProvider.districtController.text = renter.district ?? '';
    renterProvider.occupationController.text = renter.occupation ?? '';
    renterProvider.noOfMemberController.text = renter.numOfPerson.toString();
    renterProvider.nIdController.text = renter.nIdNumber.toString();

    String flatName =
        context.watch<SelectedFlatProvider>().selectedFlat!.flatName;
    String homeId = context.watch<CurrentHomeProvider>().currentHome!.homeId;
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
                Response res = await RenterService()
                    .deleteRenterFromFlat(homeId: homeId, flatId: flatName);
                if (res.code == 200) {
                  //TODO: NEED TO FIX LAGGING
                  AppWidget.showToast('গ্রাহক মুছে ফেলা হয়েছে');
                }
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('দুঃখিত, একটু পরে আবার চেষ্টা করুন')));
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
        style:
            Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey),
      ),
    ),
  );
}