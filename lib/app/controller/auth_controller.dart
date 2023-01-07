// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as https;
import 'package:my_dvm_project/app/model/auth_model/auth/login/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth_model/auth/login/new_login_model.dart';
import '../widgets/user_profile_information.dart';

//https://www.youtube.com/watch?v=nYl1M9wJxQ4
//https://www.youtube.com/watch?v=CFLR_6gB70A
//https://www.youtube.com/watch?v=auspHSmtVII

//https://www.youtube.com/watch?v=l59VGNbenLk

//https://www.youtube.com/watch?v=nYl1M9wJxQ4
//https://www.youtube.com/watch?v=CFLR_6gB70A
//https://www.youtube.com/watch?v=auspHSmtVII

// can i con

class AuthC extends ChangeNotifier {
  final box = GetStorage();
  var dio = Dio();

  Future<UserLoginModel> login(String number) async {
    const url = "https://darjisamajbayad.com/api/login";
    Map<String, String> headers = {
      "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtb2JpbGVfbm8iOiI4NzgwNzQ5MzgzIiwiaWQiOiIyNyIsInZpbGxhZ2UiOiJKdW5hZ2FkaCIsImxpdmVfYXQiOiJKdW5hZ2FkaCJ9.BGtU5-XtMlWrzT54w2DFpLAqrV_rg5uPfrLOwBG1m2k"
    };
    print(dio.options.headers);
    var response = await dio.post(url,
        data: {
          "mobile_no": number,
        },
        options: Options(headers: headers));

    var resData = response.data;
    var data = resData['data'];

    if (response.statusCode == 200) {
      // log(" token = ${resData["token"]}");
      // log("name is  = ${data["name"]}");
      // log("name is  = ${data["village"]}");
      // print('response12 ${response.data} ');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("login", resData["token"]);
      prefs.setString("login", resData["token"]);
      print('response12 ${response.statusCode} ');
      //return loginModelFromJson(response.body);

      ///store data into local-storage
      UserData userData =
          UserData.fromJson(jsonDecode(jsonEncode(response.data)));

      box.write('data', userData.toJson());
      var isMember = userData.data?.memberNumber;

      box.write('isLogin', isMember == null ? false : true);

      // aa uncmnt kryu che
      return UserLoginModel.fromMap(data);
    } else {
      const Text("Invalid Creditial");
      log("Invalid Creditial");

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        "login",
        resData['token'].toString(),
      );
    }

    return UserLoginModel(
        id: "",
        member_number: "",
        name: "",
        village: "",
        live_in: "",
        mobile_no: "",
        email: "",
        status: "",
        updated_by: "",
        updated_date: "",
        created_by: "",
        created_date: "");
  }
}

void pageRoute(String token) async {
  BuildContext? context;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("login", token);
  Navigator.push(context!,
      MaterialPageRoute(builder: (context) => UserProfileInformation()));
}
