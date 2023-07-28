import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petaldash/src/models/response_api.dart';
import 'package:petaldash/src/models/user.dart';
import 'package:petaldash/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:petaldash/src/providers/user_providers.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ClientProfileUpdateController extends GetxController{

  User user = User.fromJson(GetStorage().read('user'));

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController= TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imagefile;

  UserProvider usersProvider = UserProvider();

  ClientProfileInfoController clientProfileInfoController = Get.find();

  ClientProfileUpdateController(){
    nameController.text = user.name ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }
  void updateInfo(BuildContext context) async{
    String name = nameController.text;
    String lasName = lastnameController.text;
    String phone = phoneController.text;

    //Get.snackbar('Email', email);
    //Get.snackbar('Password', password);
    if(isValidForm(name, lasName, phone)){

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando datos...');

      User myUser = User(
        id: user.id,
        name: name,
        lastname: lasName,
        phone: phone,
        sessionToken: user.sessionToken
      );

      if (imagefile == null) {
        ResponseApi responseApi = await usersProvider.update(myUser);
        print('Response API UPDATE: ${responseApi.data} ' );
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
        progressDialog.close();
        if (responseApi.success == true){
          GetStorage().write('user', responseApi.data);
          clientProfileInfoController.user.value = User.fromJson(GetStorage().read('user') ?? {});
        }
      }else{
        Stream stream = await usersProvider.updateWithImage(myUser, imagefile!);
        stream.listen((res) {

          progressDialog.close();
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          Get.snackbar('Proceso terminado', responseApi.message ?? '');
          print('Response Api Update: ${responseApi.data}');

          if(responseApi.success== true){
            GetStorage().write('user', responseApi.data);
            clientProfileInfoController.user.value = User.fromJson(GetStorage().read('user') ?? {});
          }else{
            Get.snackbar('Registro fallido', responseApi.message ?? '');
          }

        });
      }


      progressDialog.close();

    }
  }
  bool isValidForm(String name,String lastName, String phone){
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