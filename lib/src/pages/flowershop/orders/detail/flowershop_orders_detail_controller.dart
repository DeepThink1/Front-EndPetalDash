import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:petaldash/src/models/order.dart';
import 'package:petaldash/src/models/response_api.dart';
import 'package:petaldash/src/models/user.dart';
import 'package:petaldash/src/providers/orders_provider.dart';
import 'package:petaldash/src/providers/user_providers.dart';

class FlowershopOrdersDetailController extends GetxController {

  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idDelivery = ''.obs;

  UserProvider usersProvider = UserProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;

  FlowershopOrdersDetailController() {
    print('Order: ${order.toJson()}');
    getDeliveryMen();
    getTotal();
  }

  void updateOrder() async {
    if (idDelivery.value != '') { // SI SELECCIONO EL DELIVERY
      order.idDelivery = idDelivery.value;
      ResponseApi responseApi = await ordersProvider.updateToDispatched(order);
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
      if (responseApi.success == true) {
        Get.offNamedUntil('/flowershop/home', (route) => false);
      }
    }
    else {
      Get.snackbar('Peticion denegada', 'Debes asignar el repartidor');
    }
  }

   void getDeliveryMen() async {
     var result = await usersProvider.findDeliveryMen();
     users.clear();
     users.addAll(result);
   }

  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }

}