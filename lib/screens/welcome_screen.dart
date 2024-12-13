import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../widgets/title_button_widget.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome-screen';

  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController titleAnimationController;
  late final Animation testAnimation;

  @override
  void initState() {
    titleAnimationController = AnimationController(
      duration: const Duration(
        seconds: 9,
      ),
      vsync: this,
      upperBound: 1,
    );
    testAnimation = ColorTween(begin: Colors.white, end: Colors.blue).animate(
      titleAnimationController,
    );
    titleAnimationController.forward();
    // titleAnimationController.reverse(from: 1.0);
    titleAnimationController.addListener(
      () {
        setState(() {
          // print(titleAnimationController.value);
        });
      },
    );
    // testAnimation = CurvedAnimation(
    //   parent: titleAnimationController,
    //   curve: Curves.ease,
    // );
    titleAnimationController.addStatusListener(
      (status) {
        // print(status);
        if (status == AnimationStatus.completed) {
          titleAnimationController.reverse(from: 1.0);
        } else if (status == AnimationStatus.dismissed) {
          titleAnimationController.forward();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    titleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: Colors.lime.withOpacity(titleAnimationController.value),
      backgroundColor: testAnimation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FittedBox(
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 60,
                      // height: decelerateAnimation.value * 100,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        speed: const Duration(milliseconds: 300),
                        'Flash Chat',
                        textStyle: const TextStyle(
                          fontSize: 45.0,
                          // color: Colors.black.withOpacity(titleAnimationController.value),
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                    // Text(
                    //   "Flash Chat ${titleAnimationController.value != 100 ? '${titleAnimationController.value.toInt()}%' : ""}",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TitleNavButton(
              title: 'Log In',
              routeName: LoginScreen.routeName,
              fillColor: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  LoginScreen.routeName,
                );
              },
            ),
            TitleNavButton(
              title: 'Register',
              routeName: RegistrationScreen.routeName,
              fillColor: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RegistrationScreen.routeName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
