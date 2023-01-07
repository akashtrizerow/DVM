import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../model/auth_model/auth/login/user_data.dart';
import '../model/news_feed_model/news_feed_model.dart';
import '../utils/colors.dart';

class CustomContainer extends StatefulWidget {
  CustomContainer({
    super.key,
    this.onTap,
  });

  void Function()? onTap;

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  static const platform = MethodChannel("razorpay_flutter");
  final scrollController = ScrollController();
  late Razorpay _razorpay;
  UserData? userData;
  NewsFeedModel? newsFeedModel;
  bool isLoading = false;

  List<Posts> posts = [];

  int page = 1;
  final dio = new Dio();

// page Infinitive
//https://www.youtube.com/watch?v=8UobVR7FDm0

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          posts.clear();
          newsFeedApiCall(isFromRefresh: true);
        },
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          itemCount: posts.length + 1,
          itemBuilder: (context, index) {
            return posts.length == index
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Card(
                          elevation: 2.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 170.0,
                                color: AppColors.Cardcolor,
                                child: Center(
                                  child: Image.network(posts[index].file!),
                                ),
                              ),
                              const SizedBox(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 18, 40, 0),
                                child: Text(
                                  posts[index].description ?? '',
                                  style: GoogleFonts.roboto(
                                    color: AppColors.MoneyColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),

                              //type =1 hoi to btn batavanu
                              //type = 0 hoi to btn nai batavanu :- paid lakhelu aavu joiye

                              Row(
                                children: [
                                  //   if (newsFeedModel?.posts?[index].type == 1)

                                  posts[index].type == 1
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 10, 0),
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
                                            child: Text(
                                              "PAY NOW",
                                              style: GoogleFonts.roboto(
                                                  color: AppColors
                                                      .AppBackgroundColor,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          //
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 10, 0),
                                          child: Text(
                                            "Paid",
                                            style: GoogleFonts.roboto(
                                                color: AppColors
                                                    .AppBackgroundColor,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                ],
                              ),

                              const SizedBox(
                                height: 14.0,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
          },
        ));
  }

  @override
  void initState() {
    super.initState();
    getLocalData();
    scrollController.addListener(_scrollListener);
    newsFeedApiCall(isFromRefresh: false);

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  getLocalData() {
    final box = GetStorage();
    Map<String, dynamic> dataFromLocal = box.read('data');
    userData = UserData.fromJson(dataFromLocal);
  }

  newsFeedApiCall({required bool isFromRefresh}) async {
    var dio = Dio();
//https://www.youtube.com/watch?v=Gsfjcpo6wcA
    String url = "https://darjisamajbayad.com/api/posts?page=$page";

    Map<String, String> headers = {
      "Authorization": "Bearer ${userData?.token}"

      // "Authorization":
      //     "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtb2JpbGVfbm8iOiI4NzgwNzQ5MzgzIiwiaWQiOiIyNyIsInZpbGxhZ2UiOiJKdW5hZ2FkaCIsImxpdmVfYXQiOiJKdW5hZ2FkaCJ9.BGtU5-XtMlWrzT54w2DFpLAqrV_rg5uPfrLOwBG1m2k}"
    };

    var newsFeed = {"page": page.toString(), "limit": "10"};

    var response = await dio.post(url,
        data: jsonEncode(newsFeed), options: Options(headers: headers));

    var resData = response.data;
    // ignore: unused_local_variable
    var data = resData['data'];

    if (response.statusCode == 200) {
      newsFeedModel =
          NewsFeedModel.fromJson(jsonDecode(jsonEncode(response.data)));
      posts = posts..addAll((newsFeedModel?.posts) ?? []);
      setState(() {});
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        page = page + 1;
      });
      await newsFeedApiCall(isFromRefresh: true);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _razorpay.clear();
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
