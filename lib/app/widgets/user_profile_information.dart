import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_dvm_project/app/model/news_feed_model/news_feed_model.dart';

import 'package:my_dvm_project/app/model/payment_history_model/payment_history_model.dart';

import 'package:my_dvm_project/app/model/payment_history_model/payment_history_model.dart'
    as payment;
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/auth_controller.dart';
import '../model/auth_model/auth/login/user_data.dart';
import '../model/payment_history_model/payment_history_model.dart';
import '../utils/colors.dart';
import 'custom_btn.dart';

class UserProfileInformation extends StatefulWidget {
  const UserProfileInformation({super.key});

  @override
  State<UserProfileInformation> createState() => _UserProfileInformationState();
}

class _UserProfileInformationState extends State<UserProfileInformation> {
  late Razorpay _razorpay;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  String? displayName = "";
  bool? isSwitched = false;
  var textValue = 'Unpaid';
  String number = "";
  final scrollController = ScrollController();
  int page = 1;

  bool isLoading = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Paid';
      });
      print('Paid');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Unpaid';
      });
      print('Unpaid');
    }
  }

  final box = GetStorage();
  UserData? userData;
  PaymentModel? paymentModel;
  NewsFeedModel? newsFeedModel;
  payment.Data data = payment.Data();
  List<Paid> paid = [];
  List<UnPaid>? unpaid;

  void getDataforUserProfile() {
    userData = UserData.fromJson(box.read('data'));
  }

  AuthC authC = AuthC();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthC>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              color: AppColors.PrimaryColor,
              elevation: 4,
              child: Column(
                children: [
                  Column(
                    children: [
                      Consumer<AuthC>(
                        builder: (context, value, child) => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(28.0),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        radius: 18.0,
                                        backgroundColor:
                                            AppColors.CircleBgColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 18.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userData?.data!.name ?? '',
                                          style: GoogleFonts.roboto(
                                              fontSize: 20.0,
                                              color: AppColors.partyname,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        const SizedBox(),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/home.png",
                                              width: 14.0,
                                              height: 14.0,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              userData?.data!.liveIn ?? '',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12.0,
                                                  color: AppColors.partyname,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/map.png",
                                              width: 14.0,
                                              height: 14.0,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              userData?.data!.village ?? '',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12.0,
                                                  color: AppColors.partyname,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 0, 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "ACTUAL",
                                style: GoogleFonts.roboto(
                                    fontSize: 10.0,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2.0),
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\u{20B9}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.0,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    paymentModel?.actual.toString() ?? '',
                                    style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "PAID",
                                style: GoogleFonts.roboto(
                                    fontSize: 10.0,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2.0),
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\u{20B9}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.0,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    paymentModel?.paid.toString() ?? '',
                                    style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "DUE",
                                style: GoogleFonts.roboto(
                                    fontSize: 10.0,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2.0),
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\u{20B9}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.0,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    paymentModel?.unpaid.toString() ?? '',
                                    style: GoogleFonts.roboto(
                                      fontSize: 18.0,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "History",
                    style: GoogleFonts.roboto(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackcolor,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      //if (newsFeedModel?.posts?[index].type == 1)

                      textValue,
                      style: GoogleFonts.roboto(
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Switch(
                      onChanged: toggleSwitch,
                      value: isSwitched!,
                      activeColor: AppColors.AppBackgroundColor,
                      activeTrackColor: const Color(0xffE5D3FC),
                      inactiveThumbColor: Colors.redAccent,
                      inactiveTrackColor: Colors.redAccent,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 6.0,
            ),
            // first padding
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  paid.clear();
                  paymentHistoryApiCall(isFromRefresh: true);
                },
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: paid.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return paid.length == index
                        ? Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      paid[index].title ?? '',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color:
                                            const Color.fromARGB(255, 3, 3, 3),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "\u{20B9}${paid[index].amount ?? ''}",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 2.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 46.0),
                                          child: Text(
                                            "Date :- ${paid[index].createdDate ?? ''}",
                                            style: GoogleFonts.roboto(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.TextColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 80.0),
                                          child: Text(
                                            "Location :-  ${userData?.data?.liveIn ?? ''}",
                                            style: GoogleFonts.roboto(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.TextColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        //if (newsFeedModel?.posts?[index!].type == 1)
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 6.0),
                                          width: 90.0,
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: const Text(
                                                      "Alert Dialog Box"),
                                                  content: const Text(
                                                      "Are u want to go for payment gateway mode"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14),
                                                        child: InkWell(
                                                          onTap: () {
                                                            log("r u click the openCheckOut Method");
                                                            Navigator.of(ctx)
                                                                .pop();

                                                            openCheckout();
                                                          },
                                                          child:
                                                              const Text("Yes"),
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14),
                                                        child: const Text("No"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: UIButton(
                                              color:
                                                  AppColors.AppBackgroundColor,
                                              labelText: "PAY NOW",
                                              style: GoogleFonts.roboto(
                                                letterSpacing: 2.0,
                                                fontSize: 12.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Divider(),
                                //
                                //
                              ],
                            ),
                          );
                  },
                ),
              ),
            ),

            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString(
        "displayName",
      );
    });
  }

  showName() {
    if (displayName != null) {
      return Text(
        "$displayName is Login ",
        style: GoogleFonts.roboto(
          fontSize: 16.0,
          color: Colors.white,
        ),
      );
    } else {
      return const Text("Welcome");
    }
  }

  @override
  void initState() {
    super.initState();

    getName();
    getDataforUserProfile();
    paymentHistoryApiCall(isFromRefresh: false);
    scrollController.addListener(_scrollListener);
    // payment code
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();

    _razorpay.clear();
  }

  paymentHistoryApiCall({required bool isFromRefresh}) async {
    var dio = Dio();

    String url = "https://darjisamajbayad.com/api/payment_history?page=$page";

    log(' my Url is $url');

    Map<String, String> headers = {
      "Authorization": "Bearer ${userData?.token}"
    };
    // dio.options.headers["Authorization"] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtb2JpbGVfbm8iOiI4NzgwNzQ5MzgzIiwiaWQiOiIyNyIsInZpbGxhZ2UiOiJKdW5hZ2FkaCIsImxpdmVfYXQiOiJKdW5hZ2FkaCJ9.BGtU5-XtMlWrzT54w2DFpLAqrV_rg5uPfrLOwBG1m2k";

    print(dio.options.headers);
    var response = await dio.post(url,
        data: {"from_date": "2022-11-20", "to_date": "2022-11-27"},
        options: Options(headers: headers));

    var resData = response.data;
    // ignore: unused_local_variable
    var data = resData['data'];

    if (response.statusCode == 200) {
      paymentModel =
          PaymentModel.fromJson(jsonDecode(jsonEncode(response.data)));

      paid = paid..addAll(paymentModel?.data?.paid ?? []);

      setState(() {});
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      page = page + 1;
      log(page.toString());
      await paymentHistoryApiCall(isFromRefresh: true);
      setState(() {
        isLoading = false;
      });
    }
  }

// https://github.com/razorpay/razorpay-flutter/issues/221
  void openCheckout() async {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': 100,
      'name': 'ABC',
      'description': 'XYZ',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8141175356', 'email': 'trizerow@gmail.com'},
      //
      "method": {
        "netbanking": false,
        "card": false,
        "upi": true,
        "wallet": false,
        "emi": false,
        "paylater": false,
        "lastant bank transfer": false,
        "international": false,
      },
//
//
      "config": {
        "display": {
          "hide": [
            {"method": 'paylater'},
            {"method": 'emi'},
            {"method": 'netbanking'},
            {"method": 'wallet'},
            {"method": 'international'},
          ],
          // "preferences": {
          //   "show_default_blocks": true,
          // }
        }
      },
//

      //
      'external': {
        //    'wallets': ['paytm']
        //  'wallets': ['upi'],
      }
    };

    try {
      // _razorpay.open(options);
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
      // r u there
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log('Success Response: $response');
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }
}
