// ignore_for_file: dead_code

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'app/controller/auth_controller.dart';
import 'app/screens/dashbourd/dashbourd.dart';
import 'app/screens/splash_screen/splash_screen.dart';
import 'app/utils/colors.dart';

// ye github ka token he
//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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController? textEditingController;
  final box = GetStorage();

  late bool isLogin = box.read('isLogin') ?? false;

  @override
  Widget build(BuildContext context) {
    // bool? isLogin = box.read('isLogin');

    setState(() {
      isLogin = box.read('isLogin') ?? false;
    });

    print('isLogin==$isLogin');
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (create) => AuthC())],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: AppColors.PrimaryColor,
        ),
        color: const Color.fromARGB(255, 96, 216, 10),
        debugShowCheckedModeBanner: false,
        home: isLogin ? const Dashbourd() : const SplashScreen(),
      ),
    );
  }
}
