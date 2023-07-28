
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petaldash/src/models/user.dart';

class ClientProfileInfoController extends GetxController{

  var user = User.fromJson(GetStorage().read('user') ?? {}).obs;

  void singnOut(){
    GetStorage().remove('address');
    GetStorage().remove('shopping_bag');
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false); // eliminar el historial de pantallas
  }

  void goToProfileUpdate (){
    Get.toNamed('/client/profile/update');
  }

  void goToRoles() {
    Get.offNamedUntil('/roles', (route) => false);
  }
}