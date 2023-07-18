import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/profile_app_bar.dart';
import 'components/profile_textfield.dart';

// ignore: must_be_immutable
class OwnerProfilePage extends StatelessWidget {
  const OwnerProfilePage({super.key});

  final double profileImageRadius = 60;
  final double containerHeight = 180;
  @override
  Widget build(BuildContext context) {
     

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
                title: 'Name', ),
            MakeProfileTextField(
                title: 'User Name',
                ),
            MakeProfileTextField(
              title: 'Phone ',
               
              inputType: TextInputType.number,
            ),
            MakeProfileTextField(
              title: 'বিকল্প ফোন নম্বর',
               
              inputType: TextInputType.number,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: Section(title: 'Account'),
            ),
            MakeProfileTextField(
                title: 'Email',
             
                inputType: TextInputType.emailAddress),
            MakeProfileTextField(
              title: 'Password',
             
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
