// ignore_for_file: unused_local_variable

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/number_login.dart';
import '../../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

//splash screen
//https://www.youtube.com/watch?v=jATox3OCefw

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    String? verificationId;
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: Text(
            "Darji Vikas Mandal",
            //caveat
            style: GoogleFonts.righteous(
                fontSize: 30.0,
                letterSpacing: 6.0,
                color: const Color.fromARGB(255, 246, 246, 246)),
          ),
        ),
        nextScreen: const SignWithNumber(),
        // splashTransition: SplashTransition.decoratedBoxTransition,
        splashTransition: SplashTransition.fadeTransition,
        //splashTransition: SplashTransition.scaleTransition,

        backgroundColor: AppColors.AppBackgroundColor,
        duration: 3000,
      ),
    );
  }
}
