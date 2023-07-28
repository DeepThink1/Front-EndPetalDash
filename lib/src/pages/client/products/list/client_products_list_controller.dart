import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:petaldash/src/models/category.dart';
import 'package:petaldash/src/models/product.dart';
import 'package:petaldash/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:petaldash/src/providers/categories_providers.dart';
import 'package:petaldash/src/providers/products_provider.dart';


class ClientProductsListController extends GetxController {
  //no borres lo siguiente, por que aun no se usa, pero se debe de quedar aqui
  var items = 0.obs;

  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();


  List<Category> categories = <Category>[].obs;

  ClientProductsListController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await productsProvider.findByCategory(idCategory);
  }

  void goToOrderCreate(){
    Get.toNamed('/client/orders/create');
  }

  void openBottomSheet(BuildContext context,Product product){
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => ClientProductsDetailPage(product: product,)
    );
    }
//este igual que aun no se mueva, solo lo agregue para que esto no truene xd
  void onChangeText(String text) {

    }
}