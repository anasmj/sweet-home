import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sweet_home/src/modules/authentication/compontents/button.dart';
import 'package:sweet_home/src/modules/authentication/provider/auth.notifier.dart';
import 'package:sweet_home/src/modules/authentication/provider/login.notifier.dart';
import 'package:sweet_home/src/components/app.textfield.dart';
import 'package:sweet_home/src/constants/asset.path.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              _homeImage(),
              const SizedBox(
                height: 30,
              ),
              AppTextField(
                label: 'ইমেইল',
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                label: 'পাসওয়ার্ড',
                inputType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthenticateButton(
                buttonText: 'Log In',
                isFilled: true,
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) => AuthenticateButton(
                  onPressed: () async {
                    await ref.read(authNotifier.notifier).googeLogin();
                  },
                  buttonText: 'Sign in with google',
                  faIcon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'New here? ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Consumer(
                builder: (context, ref, child) => AuthenticateButton(
                  onPressed: () {
                    ref.read(loginNotifier.notifier).state = false;
                  },
                  buttonText: 'Register',
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Image _homeImage() {
    return Image(
      height: 150,
      width: 150,
      image: AssetImage(AssetPath.homeLogoUrl),
    );
  }
}
