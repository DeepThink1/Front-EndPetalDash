import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petaldash/src/models/User.dart';
import 'package:petaldash/src/pages/client/products/list/client_products_list_page.dart';
import 'package:petaldash/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:petaldash/src/pages/flowershop/orders/list/flowershop_orders_list_page.dart';
import 'package:petaldash/src/pages/home/home_page.dart';
import 'package:petaldash/src/pages/login/login_page.dart';
import 'package:petaldash/src/pages/register/register_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petaldash/src/pages/roles/roles_page.dart';

User userSesion = User.fromJson(GetStorage().read('user') ?? {});

void main() async{
  await GetStorage.init();
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
      initialRoute: userSesion.id != null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: ()=> LoginPage()),
        GetPage(name: '/register', page: ()=> RegisterPage()),
        GetPage(name: '/home', page: ()=> HomePage()),
        GetPage(name: '/roles', page: ()=> RolesPage()),
        GetPage(name: '/flowershop/orders/list', page: () => FlowershopOrdersListPage()),
        GetPage(name: '/delivery/orders/list', page: () => DeliveryOrdersListPage()),
        GetPage(name: '/client/products/list', page: () => ClientProductsListPage()),
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
