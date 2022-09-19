import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/services/flat_services.dart';
import 'package:sweet_home/utils/compare_values.dart';
import 'package:sweet_home/utils/custom_date_time_formatter.dart';
import 'package:sweet_home/view/app_widgets.dart';

import '../../models/renter.dart';
import '../../models/response.dart';

// ignore: must_be_immutable
class RenterProfile extends StatelessWidget {
  RenterProfile({required this.renter, super.key});
  Renter renter;
  @override
  Widget build(BuildContext context) {
    String flatName = context.watch<CurrentFlatInfoProvider>().selectedFlat;
    String homeId = context.watch<CurrentHomeProvider>().currentHome!.homeId;
    return Scaffold(
      appBar: AppBar(
        title: const Text('প্রোফাইল'),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          nameHeader(context),
          makeListTile('বিকল্প ফোন নম্বর'),
          makeListTile('পেশা'),
          makeListTile('সদস্য সংখ্যা'),
          makeListTile('পূর্বের ঠিকানা'),
          makeListTile('থানা'),
          makeListTile('ইউনিয়ন'),
          makeListTile('উপজেলা'),
          makeListTile('জেলা'),
          entryDateStamp(context),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () async {
              Response res = await FlatService()
                  .deleteRenterFromFlat(homeId: homeId, flatId: flatName);
              if (res.code == 200) {
                AppWidget.showToast('গ্রাহক মুছে ফেলা হয়েছে');
              }
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('দুঃখিত, একটু পরে আবার চেষ্টা করুন')));
            },
            child: const Text('গ্রাহক মুছে ফেলুন'),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Center entryDateStamp(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Theme.of(context).primaryColor,
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

  Widget makeListTile(String title) {
    return ListTile(
      title: Text(title),
      subtitle: Text(renter.alternatePhoneNo ?? ''),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
      ),
    );
  }

  Widget nameHeader(BuildContext context) {
    return Container(
      color: Colors.blue.shade50,
      width: double.infinity,
      height: 150,
      child: Row(
        children: [
          const SizedBox(
            width: 30,
          ),
          const CircleAvatar(
            radius: 38,
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                renter.renterName,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                renter.phoneNo,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            iconSize: 18,
            onPressed: () {},
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
