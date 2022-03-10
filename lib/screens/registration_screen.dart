import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'regis';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                    height: 200.0,
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
                showCursor: true,
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
                text: 'Register',
                function: () async {
                  setState(() {
                    loading = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Get.snackbar('Registration successfully', 'Please Login');
                      Get.offAll(const WelcomeScreen());
                    }
                    setState(() {
                      loading = false;
                    });
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    if (e.toString() ==
                        '[firebase_auth/invalid-email] The email address is badly formatted.') {
                      Get.snackbar(
                        'Registration failed',
                        'Wrong email address',
                        duration: const Duration(seconds: 2),
                      );
                    }
                    if (e.toString() ==
                        '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
                      Get.snackbar(
                        'Registration failed',
                        'The email address is already in used',
                        duration: const Duration(seconds: 2),
                      );
                    }
                    if (e.toString() ==
                        '[firebase_auth/unknown] Given String is empty or null') {
                      Get.snackbar(
                        'Registration failed',
                        'Please type email and password',
                        duration: const Duration(seconds: 2),
                      );
                    }
                    if (e.toString() ==
                        '[firebase_auth/weak-password] Password should be at least 6 characters') {
                      Get.snackbar(
                        'Registration failed',
                        'Password should be at least 6 characters',
                        duration: const Duration(seconds: 2),
                      );
                    } else {
                      Get.snackbar(
                        'Registration failed',
                        'Please type email and password',
                        duration: const Duration(seconds: 2),
                      );
                    }
                    print(e);
                  }
                },
                colour: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
