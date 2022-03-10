import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:get/get.dart';

import '../components/rounded_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 400.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: 'Log In',
                function: () async {
                  setState(() {
                    loading = true;
                  });
                  try {
                    final loggedUser = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (loggedUser != null) {
                      Get.to(const ChatScreen());
                    }
                    setState(() {

                      loading = false;
                    });
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Get.snackbar(
                      'Login Failed',
                      'Please re-login',
                      duration: const Duration(milliseconds: 2000),
                    );
                    print(e);
                  }
                },
                colour: Colors.lightBlueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
