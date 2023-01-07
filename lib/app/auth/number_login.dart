// ignore_for_file: avoid_print, depend_on_referenced_packages, unused_import, unused_element, avoid_unnecessary_containers, unnecessary_null_comparison

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:my_dvm_project/app/widgets/Icon_text_input.dart';
import 'package:my_dvm_project/app/widgets/show_alert.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as https;

import '../controller/auth_controller.dart';
import '../model/screens_model.dart/member_found.dart';
import '../utils/colors.dart';
import '../utils/ui_progress_indicator.dart';
import 'package:http/http.dart' as http;

import 'verify_otp.dart';

class SignWithNumber extends StatefulWidget {
  const SignWithNumber({super.key});

  @override
  State<SignWithNumber> createState() => _SignWithNumberState();
}

class _SignWithNumberState extends State<SignWithNumber>
    with SingleTickerProviderStateMixin {
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryCode = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

//
  bool validation(int phone) {
    if (phone.toString().length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mobile number must have 10 Digits"),
        ),
      );

      return false;
    } else {
      return true;
    }
  }

  bool isLoding = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    countryCode.text = "+91";
  }

  // https://www.youtube.com/watch?v=aHnrUXqiWYE&t=83s
  // token explain

  void sendOTP() async {
    String phone = "+91${phoneController.text.trim()}";

    setState(() {
      isLoding = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          // log(verificationId); //check that id is not null here and after passsing value check
          setState(() {
            isLoding = false;
          });

          nameShow();
          Navigator.popUntil(context, (route) => route.isFirst);

          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => OTPScreen(verificationId: verificationId),
            ),
          );
        },
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("   Please enter proper mobile number"),
            ),
          );

          setState(() {
            isLoding = false;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 30));
  }

  void nameShow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("number", phoneController.text);
  }

  Future<bool> memberIsAvailble(String phone) async {
    bool isMemberAvailable = false;

    var data = await http.post(
      Uri.parse('https://darjisamajbayad.com/api/checkmember'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <dynamic, String>{
          'mobile_no': phone,
        },
      ),
    );

    var json = jsonDecode(data.body);

    if (data.statusCode == 200) {
      isMemberAvailable = true;
    } else {
      //showAlert(json['messages']['error']);
    }

    memberFound member = memberFound.fromJson(json);

    print(member.messages!.success);
    return isMemberAvailable;
  }

  //vhttps://www.youtube.com/watch?v=VPpSvgpxaQo&t=22s

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PrimaryColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 2),
                color: const Color(0xffFFFFFF),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "User your mobile to get started",
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.NumberLoginFontCOlor,
                          ),
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.AppBackgroundColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Form(
                            key: formkey,
                            child: Column(children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  SizedBox(
                                    width: 24.0,
                                    child: TextFormField(
                                      scrollPadding:
                                          EdgeInsets.only(bottom: 10.0),
                                      readOnly: true,
                                      controller: countryCode,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 14.0,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 8.0,
                                      ),
                                      child: TextFormField(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        maxLength: 10,
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        controller: phoneController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          hintText: "Enter Mobile Number",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Consumer<AuthC>(
                                    builder: (context, value, child) => InkWell(
                                        onTap: () async {
                                          if (phoneController.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Please enter Mobile Number"),
                                              ),
                                            );
                                            return;
                                          }

                                          if (validation(int.parse(
                                              phoneController.text))) {
                                            bool isMemberAvailable =
                                                await memberIsAvailble(
                                                    phoneController.text);

                                            if (isMemberAvailable) {
                                              value.login(phoneController.text);

                                              sendOTP();
                                              // aa keybourd ne unfocued krvanu che
                                              FocusScope.of(context).unfocus();
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      "Your number is not register with darji samaj bayad please contact to admin",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          // color: Colors.red,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child: Text(
                                                            "OK",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 20, 6),
                                          child: Text(
                                            "Go",
                                            style: GoogleFonts.roboto(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppColors.AppBackgroundColor,
                                            ),
                                          ),
                                        )),
                                  ),
                                  //
                                ],
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isLoding)
            const UiProgressIndicator(
              message: "Phone Number is Verify...",
            ),
        ],
      ),
    );
  }
}
