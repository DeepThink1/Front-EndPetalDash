import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petaldash/src/models/response_api.dart';
import 'package:petaldash/src/models/user.dart';
import 'package:petaldash/src/providers/user_providers.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';



class LoginController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserProvider usersProvider = UserProvider();
  File? imagefile;


  void goToRegisterPage() {
    Get.toNamed('/register');
  }


  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, password)) {

      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response Api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data); // DATOS DEL USUARIO EN SESION
        User myUser = User.fromJson(GetStorage().read('user') ?? {});

        print('Roles length: ${myUser.roles!.length}');

        if (myUser.roles!.length > 1) {
          goToRolesPage();
        }
        else { // SOLO UN ROL
          goToClientHomePage();
        }

      }
      else {
        Get.snackbar('Login fallido', responseApi.message ?? '');
      }
    }
  }

  void goToClientHomePage() {
    Get.offNamedUntil('/client/home', (route) => false);
  }

  void goToRolesPage() {
    Get.offNamedUntil('/roles', (route) => false);
  }

  bool isValidForm(String email, String password) {

    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el password');
      return false;
    }

    return true;
  }
  void goToHomePage(){
    Get.offNamedUntil('/client/products/list', (route) => false);
  }
  bool isValidFormRegister(String email,String name,String lastName, String phone, String password,   String confirmPassword){
    if(!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }
    if(email.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }
    if(name.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar tu nombre');
      return false;
    }
    if(lastName.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar tus apellidos');
      return false;
    }
    if(phone.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar tu número de telefono');
      return false;
    }
    if(password.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar la contraseña');
      return false;
    }
    if(confirmPassword.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes confirmar tu contraseña');
      return false;
    }

    if(password != confirmPassword){
      Get.snackbar('Formulario no valido', 'Las contraeñas no coinciden');
      return false;

    }

    if(imagefile==null){
      Get.snackbar('Formulario no valido', 'Debes seleccionar una imagen de perfil');
      return false;
    }

    return true;

  }

  Future<void> loginGoogleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // El usuario canceló el inicio de sesión

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final firebaseAuth.AuthCredential credential = firebaseAuth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Iniciar sesión en Firebase con las credenciales de Google
     final firebaseAuth.UserCredential userCredential = await firebaseAuth.FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseAuth.User? user = userCredential.user;

      // Aquí puedes manejar el inicio de sesión exitoso con el usuario de Firebase
      if (user != null) {
        String? email = user.email;
        String? displayName = user.displayName;
        String? phone = user.phoneNumber;
        String? password = user.uid;
        String? confirmPassword = user.uid;
        String? imagefile = user.photoURL;

        // separando apellidos y nombres
        String? name;
        String? lasName;

        if (displayName != null) {
          List<String> nameParts = displayName.split(' ');
          name = nameParts.length > 0 ? nameParts[0] : null; // El primer elemento es el nombre
          lasName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null; // El resto son los apellidos
        }


        // Obtener el ID único del usuario
        if (isValidForm(email!, password)) {

          ResponseApi responseApi = await usersProvider.login(email, password);

          print('Response Api: ${responseApi.toJson()}');

          if (responseApi.success == true) {
            GetStorage().write('user', responseApi.data); // DATOS DEL USUARIO EN SESION
            User myUser = User.fromJson(GetStorage().read('user') ?? {});

            print('Roles length: ${myUser.roles!.length}');

            if (myUser.roles!.length > 1) {
              goToRolesPage();
            }
            else { // SOLO UN ROL
              goToClientHomePage();
            }

          }

        }else if(isValidFormRegister(email,name!, lasName!, phone!,password,confirmPassword)){

          ProgressDialog progressDialog = ProgressDialog(context: context);
          progressDialog.show(max: 100, msg: 'registrando usuario...');

          User user = User(
            id: null,
            email: email,
            name: name,
            lastname: lasName,
            phone: phone,
            image: null,
            password: password,
            sessionToken:null,
          );

          Stream stream = await usersProvider.createWithImage(user, imagefile! as File);
          stream.listen((res) {
            progressDialog.close();
            ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

            if(responseApi.success== true){
              GetStorage().write('user', responseApi.data); // datos del usuario en sesion
              goToHomePage();
            }else{
              Get.snackbar('Registro fallido', responseApi.message ?? '');
            }

          });

        }
        // El usuario ha iniciado sesión correctamente con Google

        // Obtener el nombre del usuario

        // Obtener el correo electrónico del usuario


        // Puedes imprimir los datos del usuario para verlos en la consola
        print('Nombre del usuario: $displayName');
        print('Correo electrónico: $email');
        print('apellido del usuario: $lasName');
        print('nombre del usuario: $name');
        print('phone del usuario: $phone');
        print('ID del usuario: $password');
        print('image del usuario: $imagefile');
      }
    } catch (e) {
      print('Error durante el inicio de sesión con Google: $e');
    }
  }


}