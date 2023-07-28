import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petaldash/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:petaldash/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:petaldash/src/utils/custom_animated_bottom_bar.dart';
import 'package:petaldash/src/pages/delivery/home/delivery_home_controller.dart';



class DeliveryHomePage extends StatelessWidget {

  DeliveryHomeController con = Get.put(DeliveryHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottonBar(),
      body: Obx(() => IndexedStack(
        index: con.indexTab.value,
        children: [
          DeliveryOrdersListPage(),
          ClientProfileInfoPage()
        ],
      )
      )
    );
  }
  Widget _bottonBar(){
    return Obx (() =>CustomAnimatedBottomBar(
      containerHeight: 70,
      //Color(0xFFBB85B4)
      backgroundColor: Color(0xFFBB85B4),
      showElevation: true,
      itemCornerRadius: 24 ,
      curve: Curves.easeIn,
      selectedIndex: con.indexTab.value,
      onItemSelected: (index) => con.changeTab(index),
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.list),
            title: Text('Pedidos'),
            activeColor : Colors.white,
           inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
            activeColor : Colors.white,
            inactiveColor: Colors.black
        ),
      ],
    )
    );
  }
}
