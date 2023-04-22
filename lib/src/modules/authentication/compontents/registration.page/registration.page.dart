import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/modules/authentication/compontents/button.dart';
import 'package:sweet_home/src/modules/authentication/provider/auth.notifier.dart';
import 'package:sweet_home/src/modules/authentication/provider/login.notifier.dart';
import 'package:sweet_home/src/components/app.textfield.dart';
import 'package:sweet_home/src/utils/validators.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: ref.read(authNotifier.notifier).registrationFormKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              // Image(
              //   height: 150,
              //   width: 150,
              //   image: AssetImage(AppIcons.homeLogoUrl),
              // ),
              const SizedBox(
                height: 30,
              ),
              AppTextField(
                label: 'নাম',
                onChanged: ref.read(authNotifier.notifier).onNameChange,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 30,
              ),
              AppTextField(
                label: 'ইমেইল',
                onChanged: ref.read(authNotifier.notifier).onEmailChange,
                validationFunciton: Validator.checkEmpty,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                onChanged: ref.read(authNotifier.notifier).onPassChange,
                label: 'পাসওয়ার্ড',
                validationFunciton: Validator.password,
                inputType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: AuthenticateButton(
                    onPressed: () async {
                      ref.read(authNotifier.notifier).register();
                    },
                    buttonText: 'রেজিস্ট্রেশন',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const LoginOption()
            ],
          ),
        ),
      ),
    );
  }
}

class LoginOption extends StatelessWidget {
  const LoginOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'একাউন্ট আছে?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        Consumer(
          builder: (context, ref, child) => TextButton(
            onPressed: () {
              ref.read(loginNotifier.notifier).state = true;
            },
            child: const Text(
              'লগ ইন',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
