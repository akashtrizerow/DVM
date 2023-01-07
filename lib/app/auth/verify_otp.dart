// ignore_for_file: use_build_context_synchronously, must_be_immutable, camel_case_types, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';

import '../screens/dashbourd/dashbourd.dart';
import '../utils/ui_progress_indicator.dart';

///
//https://www.youtube.com/watch?v=__kiFQsidMQ
//
//https://www.youtube.com/watch?v=QBwLJKbCIlo&t=758s

// second code

class OTPScreen extends StatefulWidget {
  final String verificationId;
  final TextEditingController? textEditingController;

  const OTPScreen({
    Key? key,
    required this.verificationId,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}
// https://pub.dev/packages/otp_text_field/versions/1.1.1

class _OTPScreenState extends State<OTPScreen> {
  bool isLoding = false;
  int pinIndex = 0;

  TextEditingController otpcontroller = TextEditingController();

  bool validation(String pin) {
    String otp = pin;
    if (otp.toString().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP number must have 6 Digit code"),
        ),
      );

      return false;
    } else {
      return true;
    }
  }

  verifyOTP(String pin) async {
    String otp = pin;

    setState(() {
      isLoding = true;
    });

    PhoneAuthCredential credential = await PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      //showAlert("Verified OTP");

      if (userCredential.user != null) {
        setState(() {
          isLoding = false;
        });

        Navigator.popUntil(context, (route) => route.isFirst);

        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const Dashbourd(),
          ),
        );
      }
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("   Please enter proper otp code"),
        ),
      );

      setState(() {
        isLoding = false;
      });
    }
  }

  List<String> currentPin = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  TextEditingController pinFiveController = TextEditingController();
  TextEditingController pinSixController = TextEditingController();

  var outLineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.pinkAccent));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: const Color(0xFF201E1F),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            //

            Column(
              children: [
                const SizedBox(
                  height: 94.0,
                ),
                buildSecurityText(),
                const SizedBox(
                  height: 54.0,
                ),
                buildFourDigitPasscode(),
                const SizedBox(
                  height: 34.0,
                ),
                buildPinRow(),
                buildNumberPad(),
              ],
            ),
            if (isLoding)
              const UiProgressIndicator(
                message: "OTP is Verify...",
              ),
          ],
        ),
      ),
    );
  }

  buildNumberPad() {
    return Expanded(
        child: Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  keybourdNumber(
                    n: 1,
                    onPressed: () {
                      pinIndexSetup("1");
                    },
                  ),
                  keybourdNumber(
                    n: 2,
                    onPressed: () {
                      pinIndexSetup("2");
                    },
                  ),
                  keybourdNumber(
                    n: 3,
                    onPressed: () {
                      pinIndexSetup("3");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  keybourdNumber(
                    n: 4,
                    onPressed: () {
                      pinIndexSetup("4");
                    },
                  ),
                  keybourdNumber(
                    n: 5,
                    onPressed: () {
                      pinIndexSetup("5");
                    },
                  ),
                  keybourdNumber(
                    n: 6,
                    onPressed: () {
                      pinIndexSetup("6");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  keybourdNumber(
                    n: 7,
                    onPressed: () {
                      pinIndexSetup("7");
                    },
                  ),
                  keybourdNumber(
                    n: 8,
                    onPressed: () {
                      pinIndexSetup("8");
                    },
                  ),
                  keybourdNumber(
                    n: 9,
                    onPressed: () {
                      pinIndexSetup("9");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 108.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: const Color(0xffBCBCBC),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        clearPin();
                      },
                      child: Icon(
                        Icons.clear_outlined,
                        color: Colors.black,
                        size: 30.0 * MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                  ),
                  keybourdNumber(
                    n: 0,
                    onPressed: () {
                      pinIndexSetup("0");
                    },
                  ),
                  Container(
                    width: 108.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      //     color: const Color(0xff2196F3),
                      color: const Color(0xffBCBCBC),

                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        await verifyOTP(currentPin.join().toString());
                      },
                      child: Icon(
                        Icons.check,
                        color: Colors.black,
                        size: 30.0 * MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  clearPin() {
    if (pinIndex == 0) {
      pinIndex = 0;
    } else if (pinIndex == 6) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    } else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] == "";
      pinIndex--;
    }
  }

  pinIndexSetup(String text) {
    if (pinIndex == 0) {
      pinIndex = 1;
      // pinIndex = 0;
    } else if (pinIndex < 6) {
      pinIndex++;
    }
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;

    String strpin = "";
    for (var e in currentPin) {
      strpin += e;
    }
    // ignore: avoid_print
    if (pinIndex == 6) print(strpin);
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
      case 5:
        pinFiveController.text = text;
        break;
      case 6:
        pinSixController.text = text;
        break;
    }
  }

  buildExitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {},
            height: 50.0,
            minWidth: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  buildSecurityText() {
    return Text(
      "Setup passcode for login",
      style: GoogleFonts.roboto(
        // color: const Color(0xffBCBCBC),
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  buildFourDigitPasscode() {
    return Text(
      "Enter 6 digit passcode",
      style: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PinNumber(
          outlineInputBorder: outLineInputBorder,
          textEditingController: pinOneController,
          myotp: '',
        ),
        PinNumber(
          outlineInputBorder: outLineInputBorder,
          textEditingController: pinTwoController,
          myotp: '',
        ),
        PinNumber(
          outlineInputBorder: outLineInputBorder,
          textEditingController: pinThreeController,
          myotp: '',
        ),
        PinNumber(
          outlineInputBorder: outLineInputBorder,
          textEditingController: pinFourController,
          myotp: '',
        ),
        PinNumber(
          outlineInputBorder: outLineInputBorder,
          textEditingController: pinFiveController,
          myotp: '',
        ),
        PinNumber(
          outlineInputBorder: outLineInputBorder,
          textEditingController: pinSixController,
          myotp: '',
        ),
      ],
    );
  }
}

class PinNumber extends StatelessWidget {
  // make 6 difrent string variable stop one min ok wait i am waiting
  final TextEditingController? textEditingController;
  final OutlineInputBorder? outlineInputBorder;

  OtpFieldController? otpController = OtpFieldController();

  var myotp = "";
  PinNumber(
      {super.key,
      required this.textEditingController,
      this.outlineInputBorder,
      required this.myotp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.0,
      //  child: TextField(
      child: TextFormField(
        onChanged: (value) {
          myotp = myotp + value;
        },
        controller: textEditingController,
        enabled: false,
        maxLength: 1,
        obscureText: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintStyle: GoogleFonts.roboto(
            color: const Color(0xffBCBCBC),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),

          hintText: '0',
          //
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 5,
            ),
            //borderSide: BorderSide.none,
          ),
          //
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 5,
            ),
          ),

          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.white,
            ),
          ),
        ),

        style: GoogleFonts.roboto(
          fontSize: 20.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),

        //
      ),
    );
  }
}

class keybourdNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;

  const keybourdNumber({super.key, required this.n, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: 108.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: const Color(0xffBCBCBC),
        borderRadius: BorderRadius.circular(6.0),

        //   color: Colors.purpleAccent.withOpacity(0.1),
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          //60
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 90.0,
        child: Text(
          "$n",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 26 * MediaQuery.of(context).textScaleFactor,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
