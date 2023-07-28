import 'package:flutter/material.dart';
import 'package:petaldash/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:get/get.dart';


class ClientProfileInfoPage extends StatelessWidget {
  ClientProfileInfoController con = Get.put(ClientProfileInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
        //Posicionar elementos uno encima de otro
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(context),
          Column(
            children: [
              _buttonSingOut(),
              _buttonRoles()
            ],
          )
        ],
      )),
    );
  }


  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.35,
      color: Color(0xFB2B2B2),
      alignment: Alignment.topCenter,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.3),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.65,

      child: SingleChildScrollView(
        child: Column(
          children: [
            _textName(),
            _textEmail(),
            _textPhone(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }

  Widget _textName() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 15),
        child: ListTile (
          leading: Icon(Icons.person),
          title: Text('${con.user.value.name ?? ''} ${con.user.value.lastname ?? ''} '),
          subtitle: Text('Nombre de usuario'),
        ),);
  }

  Widget _textEmail() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: ListTile (
          leading: Icon(Icons.email),
          title: Text(con.user.value.email ?? ''),
          subtitle: Text('Email'),
    ),
    );
  }
  Widget _textPhone() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListTile (
        leading: Icon(Icons.phone),
        title: Text(con.user.value.phone ?? ''),
        subtitle: Text('Telefono'),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 60, vertical: 60),
      child: ElevatedButton(
          onPressed: () => con.goToProfileUpdate(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 13)),
          child: Text(
            'Actualizar datos',
            style: TextStyle(color: Colors.black),
          )),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 40),
        child: CircleAvatar(
          backgroundImage: con.user.value.image!= null
              ? NetworkImage(con.user.value.image!)
              : AssetImage('assets/img/user.png') as ImageProvider,
          radius: 60,
          backgroundColor: Color(0xFFBB85B4),
        ),
      ),
    );
  }

  Widget _buttonRoles() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () => con.goToRoles(),
        icon: Icon(
          Icons.supervised_user_circle,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }

  Widget _buttonSingOut() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 20, top: 5),
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () => con.singnOut(),
          icon: Icon(
            Icons.power_settings_new,
            color: Colors.black,
            size: 20,
          ),
        ), //> IconButton
      ), // Container
    ); // SafeArea
  }

}

