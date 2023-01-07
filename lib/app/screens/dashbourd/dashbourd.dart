// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_dvm_project/app/model/auth_model/auth/login/user_data.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/number_login.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/dashbourd_container.dart';
import '../../widgets/drawer.dart';
import '../../widgets/user_profile_information.dart';

class Dashbourd extends StatefulWidget {
  const Dashbourd({super.key});

  @override
  State<Dashbourd> createState() => _DashbourdState();
}

class _DashbourdState extends State<Dashbourd>
    with SingleTickerProviderStateMixin {
  @override
  // ignore: override_on_non_overriding_member
  late TabController _controller;

  TextEditingController phoneController = TextEditingController();
  final box = GetStorage();
  UserData? userData;
  bool viewAdminUsers = false;
  String token = "";
  static const platform = MethodChannel("razorpay_flutter");
  late Razorpay _razorpay;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("login")!;
    });

    Map<String, dynamic> dataFromLocal = box.read('data');

    userData = UserData.fromJson(dataFromLocal);
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    getData();
  }

  // ignore: unused_element
  _tabViewBind() {}

//
  void logout() async {
    await FirebaseAuth.instance.signOut();
    box.write('isLogin', false);

    GetStorage().erase();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const SignWithNumber(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: CustomAppbar(
        title: "Home",
        style: GoogleFonts.roboto(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
        backgroundColor: AppColors.AppBackgroundColor,
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_rounded,
              color: AppColors.AppbarIconColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 6, 16, 10),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Alert Dialog Box"),
                    content: const Text("Are u want to Logout"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(ctx).pop();

                              logout();
                            },
                            child: const Text("Yes"),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: const Text("No"),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: AppColors.AppbarIconColor,
              ),
            ),
          ),
        ],
        bottom: TabBar(
          padding: const EdgeInsets.only(),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: [
            Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(6.0),
                    child: Text(
                      'NEWS',
                      style: GoogleFonts.roboto(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'PAYMENT HISTORY',
                    style: GoogleFonts.roboto(
                        letterSpacing: 1.0,
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ],
          onTap: (index) {
            print(index);
          },
          controller: _controller,
        ),
      ),
      body: Center(
          child: TabBarView(
        controller: _controller,
        children: [
          CustomContainer(),
          UserProfileInformation(),
        ],
      )),
    );
  }
}
