import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petaldash/src/models/address.dart';
import 'package:petaldash/src/models/order.dart';
//import 'package:petaldash/src/models/order.dart';
import 'package:petaldash/src/models/product.dart';
import 'package:petaldash/src/models/response_api.dart';
import 'package:petaldash/src/models/user.dart';
import 'package:petaldash/src/providers/address_provider.dart';
import 'package:petaldash/src/providers/orders_provider.dart';

class ClientAddressListController extends GetxController {

  List<Address> address = [];
  AddressProvider addressProvider = AddressProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  var radioValue = 0.obs;

  ClientAddressListController() {
    print('LA DIRECCION DE SESION ${GetStorage().read('address')}');
  }
  //
  Future<List<Address>> getAddress() async {
    address = await addressProvider.findByUser(user.id ?? '');
    print('Address ${address}');
    Address a = Address.fromJson(GetStorage().read('address') ?? {}) ; // DIRECCION SELECCIONADA POR EL USUARIO
    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) { // LA DIRECCION DE SESION COINCIDE CON UN DATOS DE LA LISTA DE DIRECCIONES
      radioValue.value = index;
    }

    return address;
  }
  //
  void createOrder() async {
    Address a = Address.fromJson(GetStorage().read('address') ?? {}) ;
    List<Product> products =[];
    if (GetStorage().read('shopping_bag') is List<Product>) {
      products = GetStorage().read('shopping_bag');
    }else{
      products = Product.fromJsonList(GetStorage().read('shopping_bag'));
    }

    Order order = Order(
      idClient: user.id,
      idAddress: a.id,
      products: products
    );

    ResponseApi responseApi = await ordersProvider.create(order);
    Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
    if(responseApi.success == true){
      GetStorage().remove('shopping_bag');
      Get.toNamed('/client/payments/create');
    }

    //Get.toNamed('/client/payments/create');
  }
  void handleRadioValueChange(int? value) {
    radioValue.value = value!;
    print('VALOR SELECCIONADO ${value}');
    GetStorage().write('address', address[value].toJson());
    update();
  }

  void goToAddressCreate() {
    Get.toNamed('/client/address/create');
  }

}