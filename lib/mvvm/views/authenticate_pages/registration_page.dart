import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sweet_home/mvvm/models/response.dart';

import '../../repositories/auth_service.dart';
import '../app_widgets.dart';
import '../resources/app_icons.dart';
import 'components/custom_textfield.dart';

class RegistrationPage extends StatefulWidget {
  final Function toggleView;

  const RegistrationPage({Key? key, required this.toggleView})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String errorMsg = '';

  bool _isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: Lottie.asset(
                AppIcons.tranparentLoad,
                height: 150,
                repeat: true,
              ),
            )
          : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
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
                      label: 'নাম',
                      textEditingController: _nameController,
                      validationFunciton: nameValidator,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      label: 'ইমেইল',
                      textEditingController: _emailController,
                      validationFunciton: emailValidator,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      textEditingController: _passController,
                      label: 'পাসওয়ার্ড',
                      validationFunciton: passwordValidator,
                      inputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      errorMsg,
                      style: const TextStyle(fontSize: 14, color: Colors.red),
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
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              Response response =
                                  await AuthService().registerWithEmailAndPass(
                                email: _emailController.text,
                                password: _passController.text,
                                userName: _nameController.text,
                              );
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
                            'রেজিস্ট্রেশন',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    loginButton(),
                  ],
                ),
              ),
            ),
    );
  }

  Row loginButton() {
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
        TextButton(
          onPressed: () {
            widget.toggleView();
          },
          child: const Text(
            'লগ ইন',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  String? emailValidator(String? val) {
    return val!.isEmpty ? 'ইমেইল দেওয়া হয়নি' : null;
  }

  String? nameValidator(String? val) {
    // TODO: more logc neededed

    return val!.isEmpty ? 'নাম দেওয়া হয়নি' : null;
    //more logic
  }

  String? passwordValidator(String? val) {
    return val != null
        ? val.length < 6
            ? 'পাসওয়ার্ড ৬ অক্ষরের হতে হবে'
            : null
        : null;
  }
}
