import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petaldash/src/pages/login/login_page.dart';
import 'package:petaldash/src/pages/register/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState

  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Delivery PetalDash',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=> LoginPage()),
        GetPage(name: '/register', page: ()=> RegisterPage())
      ],
      theme: ThemeData(
         primaryColor: Color(0xFFBB85B4),
         colorScheme: ColorScheme(
           secondary: Color(0xFF540748),
           primary: Color(0xFFBB85B4),
           brightness: Brightness.light,
           onBackground: Colors.grey,
           onPrimary: Colors.grey,
           surface: Colors.grey,
           onSurface: Colors.grey,
           error: Colors.grey,
           onError: Colors.grey,
           onSecondary: Colors.grey,
           background: Colors.grey
         )
      ),
      navigatorKey: Get.key,
    );
  }
}
