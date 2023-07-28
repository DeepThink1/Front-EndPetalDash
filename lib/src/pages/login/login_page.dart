import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petaldash/src/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {

  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textDontHaveAccount(),
      ),
      body: Stack( //Posicionar elementos uno encima de otro
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column( //Posicionar elementos uno  debajo del otro
            children: [
              _imageCover(),
              _textAppName()
            ],)
        ],
      ),
    );
  }

  //PRIVATE
  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 15),
        alignment: Alignment.topCenter,
        child: Image.asset(
          'assets/img/delivery.png',
          width: 180,
          height: 180,
        ),
      ),
    );
  }


  Widget _textAppName() {
    return Text(
      'BIENVENIDO',
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.49,
      color: Color(0xFFBB85B4),
      alignment: Alignment.topCenter,
    );
  }


  Widget _textDontHaveAccount() {
    return Row( // Permite acomodar elementos 1 al lado del otro
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("¿No tienes cuenta?",
          style: TextStyle(
              color: Colors.black,
              fontSize: 17
          ),
        ),

        SizedBox(width: 7),
        GestureDetector(
          onTap: () => con.goToRegisterPage(),
          child: Text("Registrate Aqui",
            style: TextStyle(
                color: Color(0xFFBB85B4),
                fontWeight: FontWeight.bold,
                fontSize: 17
            ),),
        )
      ],
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery
          .of(context)
          .size
          .height * 0.43, left: 50, right: 50),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.45,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldEmail(),
            _textFieldPassword(),
            _buttonLogin(),
            _buttonLoginGoogle(context)
          ],
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 40),
        child: Text('INGRESE SUS CREDENCIALES',
          style: TextStyle(
              color: Colors.black
          ),
        ));
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electronico',
            prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            prefixIcon: Icon(Icons.lock)
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
          onPressed: () => con.login(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 13)
          ),
          child: Text('LOGIN', style: TextStyle(
              color: Colors.black
          ),
          )
      ),
    );
  }

  Widget _buttonLoginGoogle(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
        onPressed: () => con.loginGoogleSignIn(context),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          side: BorderSide(color: Colors.grey, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/google.png',
              height: 25,
              width: 25,
            ),
            SizedBox(width: 10),
            Text(
              'LOGIN WITH GOOGLE',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
