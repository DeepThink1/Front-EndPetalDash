import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FlowershopHomeController extends GetxController {
   //observable
  var indexTab = 0.obs;

  void changeTab( int index){
    indexTab.value = index;
  }

  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false); // ELIMINAR EL HISTORIAL DE PANTALLAS
  }

}