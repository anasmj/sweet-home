import 'package:flutter/material.dart';
import 'package:sweet_home/models/response.dart';

import '../../services/auth_service.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;
  const SignInPage({required this.toggleView, key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in'),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(Icons.person),
            label: const Text('Register'),
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (val) => setState(() {
                    _email = val;
                  }),
                  decoration: inputDecoration(label: 'Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (val) => setState(() {
                    _password = val;
                  }),
                  decoration: inputDecoration(label: 'Password'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    // AuthService().signInWithEmailAndPassword(
                    //     email: _email, pass: _password, context: context);
                  },
                  child: const Text('Sign in'),
                ),
                TextButton(
                  onPressed: () async {
                    //response should contain AppUser object container user information
                    Response response = await AuthService().signInAnon();
                    if (response.code == 200) {
                      print(response.user!.userId);
                    }
                  },
                  child: const Text('Sign in ann'),
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
