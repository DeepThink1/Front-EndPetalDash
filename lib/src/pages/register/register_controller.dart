import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petaldash/src/models/response_api.dart';
import 'package:petaldash/src/providers/user_providers.dart';
import 'package:petaldash/src/models/user.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController= TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UserProvider userProvider = UserProvider();
  ImagePicker picker = ImagePicker();
  File? imagefile;


  void goToRegisterPage(){
    Get.toNamed('/register');
  }

  void register(BuildContext context) async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lasName = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    //Get.snackbar('Email', email);
    //Get.snackbar('Password', password);
    if(isValidForm(email,name, lasName, phone,password,confirmPassword)){

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

      Stream stream = await userProvider.createWithImage(user, imagefile!);
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
  }

  void goToHomePage(){
    Get.offNamedUntil('/client/products/list', (route) => false);
  }

  bool isValidForm(String email,String name,String lastName, String phone, String password,   String confirmPassword){
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

  Future selectImage(ImageSource imageSource) async{
    XFile? image = await picker.pickImage(source: imageSource);
    if(image != null){
      imagefile = File (image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
      onPressed: (){
        Get.back();
        selectImage(ImageSource.gallery);
      },
      child: Text('Galeria',
        style: TextStyle(color: Colors.black),
      )
    );
    Widget cameraButton = ElevatedButton(
        onPressed:() {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text('Camara',
          style: TextStyle(color: Colors.black),
        )
    );


    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;

    });
  }



}
