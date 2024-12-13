import 'package:flutter/material.dart';

import 'package:chat_flash/screens/chat_screen.dart';
import 'package:chat_flash/services/auth_service.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../constants.dart';
import '../widgets/title_button_widget.dart';
import 'welcome_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/registration-screen';

  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: _isSaving,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: SizedBox(
                        height: 200.0,
                        child: Image.asset('assets/images/logo.png'),
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
                      decoration: kInputDecoration.copyWith(
                        hintText: 'Enter your email.',
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
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
                      decoration: kInputDecoration.copyWith(
                        hintText: 'Enter your password.',
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TitleNavButton(
                      title: 'Register',
                      routeName: WelcomeScreen.routeName,
                      fillColor: Colors.blueAccent,
                      onPressed: () async {
                        try {
                          setState(() {
                            _isSaving = true;
                          });
                          // const Duration threeSeconds = Duration(seconds: 3);
                          // await Future.delayed(threeSeconds);
                          await AuthService().signup(email: email, password: password);
                          setState(() {
                            _isSaving = false;
                          });
                        } catch (e) {
                          print('registration error: $e');
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
