import 'package:flutter/material.dart';
import 'package:sweet_home/models/response.dart';
import 'package:sweet_home/views/app_widgets.dart';

import '../../services/auth_service.dart';

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
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Register'),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(Icons.person),
            label: const Text('Sign In'),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? 'Enter a valid email' : null;
                  },
                  onChanged: (val) => setState(() {
                    _email = val;
                  }),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: inputDecoration(label: 'Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) {
                    return val != null
                        ? val.length < 6
                            ? 'password at least have 6 characters'
                            : null
                        : null;
                  },
                  onChanged: (val) => setState(() {
                    _password = val;
                  }),
                  decoration: inputDecoration(label: 'Password'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  errorMsg,
                  style: const TextStyle(fontSize: 14, color: Colors.red),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Response response = await AuthService()
                          .registerWithEmailAndPass(_email, _password);
                      if (response.code != 200) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          AppWidget.snackBarContent(
                              msg: response.body ?? 'Unknown error occured '),
                        );
                      }
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration({required String label}) {
    return InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ));
  }
}
