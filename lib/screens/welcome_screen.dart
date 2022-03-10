import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      // upperBound: 100,
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    controller.forward();

    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    // animation.addStatusListener((status) {
    //   if(status == AnimationStatus.completed){
    //     controller.reverse(from: 1.0);
    //   }else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      child: Image.asset('images/logo.png'),
                      height: 80.0,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25.0,
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 45.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Let\'s chat',
                        speed: const Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              text: 'Log In',
              function: () {
                Get.to(() => const LoginScreen());
              },
              colour: Colors.lightBlueAccent,
            ),
            const SizedBox(
              height: 26.0,
            ),
            RoundedButton(
              text: 'Register',
              function: () {
                Get.to(() => const RegistrationScreen());
              },
              colour: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
// Navigator.pushNamed(context, LoginScreen.id);
