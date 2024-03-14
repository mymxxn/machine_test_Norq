import 'dart:developer';

import 'package:get/get.dart';
import 'package:machine_test/Controller/Local%20DB%20Controller/product_local_controller.dart';
import 'package:machine_test/Model/product_list_model.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCartList();
  }

  final productListLoclController = Get.put(ProductLocalController());
  var cartList = [].obs;
  getCartList() async {
    await productListLoclController.getProductList();
    if (productListLoclController.productList.isNotEmpty) {
      cartList.value = productListLoclController.productList;
    }
    update();
  }

  addProduct({required ProductListModel item, required bool isAdd}) async {
    if (isAdd) {
      item.quantity = (item.quantity ?? 0) + 1;
    } else {
      if ((item.quantity ?? 0) >= 1) {
        item.quantity = (item.quantity ?? 0) - 1;
      } else {
        item.isCart = 0;
      }
    }
    if (item.isCart == 1) {
      productListLoclController.updateProduct(
          id: item.id ?? 0, quantity: item.quantity ?? 0);
    } else {
      productListLoclController.deletProduct(id: item.id ?? 0);
    }
    getCartList();
    update();
  }
}
