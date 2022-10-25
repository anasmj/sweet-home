import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/new_renter_view_model.dart';
import 'components/profile_app_bar.dart';
import 'components/profile_textfield.dart';

// ignore: must_be_immutable
class OwnerProfilePage extends StatelessWidget {
  const OwnerProfilePage({super.key});

  final double profileImageRadius = 60;
  final double containerHeight = 180;
  @override
  Widget build(BuildContext context) {
    final renterProvider = context.read<NewRenterViewModel>();

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const ProfileAppBar(),
            const SizedBox(height: 70),
            const Section(title: 'Personal Info'),
            const SizedBox(
              height: 10,
            ),
            MakeProfileTextField(
                title: 'Name', controller: renterProvider.renterNameController),
            MakeProfileTextField(
                title: 'User Name',
                controller: renterProvider.renterNameController),
            MakeProfileTextField(
              title: 'Phone ',
              controller: renterProvider.phoneController,
              inputType: TextInputType.number,
            ),
            MakeProfileTextField(
              title: 'বিকল্প ফোন নম্বর',
              controller: renterProvider.altPhoneController,
              inputType: TextInputType.number,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: Section(title: 'Account'),
            ),
            MakeProfileTextField(
                title: 'Email',
                controller: renterProvider.previousLocationController,
                inputType: TextInputType.emailAddress),
            MakeProfileTextField(
              title: 'Password',
              controller: renterProvider.subDistrictController,
              inputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            TextButton(
              onPressed: () async {},
              child: const Text(
                'Account Delete',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
