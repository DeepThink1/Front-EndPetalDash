import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //Posicionar elementos uno encima de otro
        children: [_backgroundCover(context), _boxForm(context), _imageUser(), _buttonBack()],
      ),
    );
  }
}

Widget _backgroundCover(BuildContext context) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.35,
    color: Color(0xFFBB85B4),
    alignment: Alignment.topCenter,
  );
}

Widget _boxForm(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50),
    height: MediaQuery.of(context).size.height * 0.65,
    decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
      BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
    ]),
    child: SingleChildScrollView(
      child: Column(
        children: [
          _textYourInfo(),
          _textFieldEmail(),
          _textFieldName(),
          _textFieldLastName(),
          _textFieldPhone(),
          _textFieldPassword(),
          _textFieldConfirmPassword(),
          _buttonRegister()
        ],
      ),
    ),
  );
}

Widget _textYourInfo() {
  return Container(
      margin: EdgeInsets.only(top: 40, bottom: 15),
      child: Text(
        'INGRESE SUS DATOS',
        style: TextStyle(color: Colors.black),
      ));
}

Widget _textFieldEmail() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Correo electronico', prefixIcon: Icon(Icons.email)),
    ),
  );
}

Widget _textFieldPassword() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: TextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration:
          InputDecoration(hintText: 'Contraseña', prefixIcon: Icon(Icons.lock)),
    ),
  );
}

Widget _textFieldName() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: TextField(
      keyboardType: TextInputType.text,
      decoration:
          InputDecoration(hintText: 'Nombre', prefixIcon: Icon(Icons.person)),
    ),
  );
}

Widget _textFieldLastName() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Apellido', prefixIcon: Icon(Icons.person_outline)),
    ),
  );
}

Widget _textFieldPhone() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: TextField(
      keyboardType: TextInputType.phone,
      decoration:
          InputDecoration(hintText: 'Telefono', prefixIcon: Icon(Icons.phone)),
    ),
  );
}

Widget _textFieldConfirmPassword() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: TextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Confirmar contraseña',
          prefixIcon: Icon(Icons.lock_outline)),
    ),
  );
}

Widget _buttonRegister() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 13)),
        child: Text(
          'REGISTRARSE',
          style: TextStyle(color: Colors.black),
        )),
  );
}

Widget _imageUser() {
  return SafeArea(
    child: Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 40),
      child: GestureDetector(
        onTap: () {},
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/img/user.png'),
          radius: 60,
          backgroundColor: Color(0xFFBB85B4),
        ),
      ),
    ),
  );
}

Widget _buttonBack() {
  return SafeArea(
    child: Container(
      margin: EdgeInsets.only(left: 20, top: 5),
      child: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 20,
        ),
      ), //> IconButton
    ), // Container
  ); // SafeArea
}
