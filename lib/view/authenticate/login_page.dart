import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../models/response.dart';
import '../../services/auth_service.dart';
import '../app_widgets.dart';
import '../resources/app_icons.dart';
import 'components/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  const LoginPage({required this.toggleView, key}) : super(key: key);

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<LoginPage> {
  final _signInFormKey = GlobalKey<FormState>();
  // final String _email = '';
  // final String _password = '';

  bool _isLoading = false;
  final TextEditingController _signInEmailController = TextEditingController();
  final TextEditingController _signInPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? emailValidator(String? val) {
      return val!.isEmpty ? 'ইমেইল দেওয়া হয়নি' : null;
    }

    String? passwordValidator(String? val) {
      return val != null
          ? val.length < 6
              ? 'পাসওয়ার্ড অন্তত ৬ অক্ষরের দিন'
              : null
          : null;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: Lottie.asset(
                AppIcons.tranparentLoad,
                height: 80,
                repeat: true,
              ),
            )
          : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _signInFormKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image(
                      height: 150,
                      width: 150,
                      image: AssetImage(AppIcons.homeLogoUrl),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      label: 'ইমেইল',
                      textEditingController: _signInEmailController,
                      validationFunciton: emailValidator,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      textEditingController: _signInPassController,
                      label: 'পাসওয়ার্ড',
                      validationFunciton: passwordValidator,
                      inputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_signInFormKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              Response response = await AuthService()
                                  .signInWithEmailAndPass(
                                      _signInEmailController.text,
                                      _signInPassController.text);
                              if (response.code != 200) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  AppWidget.snackBarContent(
                                      msg: response.body ??
                                          'Unknown error occured '),
                                );
                              }
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          child: const Text(
                            'লগ ইন করুন',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(child: Text('কোনও একাউন্ট নেই? ')),
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: const Text(
                          'একাউন্ট খুলুন',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
