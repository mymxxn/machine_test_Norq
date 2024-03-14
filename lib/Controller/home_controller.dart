import 'dart:developer';

import 'package:get/get.dart';
import 'package:machine_test/Controller/Local%20DB%20Controller/product_local_controller.dart';
import 'package:machine_test/Controller/Local%20DB%20Controller/rating_local_controller.dart';
import 'package:machine_test/Model/product_list_model.dart';
import 'package:machine_test/Services/Api%20Services/common_api_services.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  final productLocalController = Get.put(ProductLocalController());
  final rateingLocalController = Get.put(RatingLocalController());
  var productList = [].obs;
  var isLoading = false.obs;
  var quantity = 0.obs;

  getProducts() async {
    isLoading.value = true;
    var result;

    try {
      var feedback = await ApiManger.fetchData();
      if (feedback != null) {
        result =
            feedback.map((data) => ProductListModel.fromJson(data)).toList();
        for (var item in result) {
          item.quantity = 0;
          item.isCart = 0;
        }
        productList.value = result;
      }
      isLoading.value = false;
    } finally {}
    update();
  }

  addProduct({required ProductListModel item, required bool isAdd}) async {
    if (isAdd) {
      item.quantity = (item.quantity ?? 0) + 1;
      int quantity = item.quantity ?? 0;

      if (item.isCart == 0) {
        item.isCart = 1;
        await productLocalController.insertProduct(product: item);
        if (item.rating != null) {
          await rateingLocalController.insertRating(
              rating: RatingModel(
                  id: item.id,
                  count: item.rating?.count ?? 0,
                  rate: item.rating?.rate ?? 0));
        }
      } else {
        item.isCart = 1;
        productLocalController.updateProduct(
            id: item.id ?? 0, quantity: quantity);
      }
    } else {
      if ((item.quantity ?? 0) >= 1) {
        item.quantity = (item.quantity ?? 0) - 1;
        productLocalController.updateProduct(
            id: item.id ?? 0, quantity: item.quantity ?? 0);
      } else {
        item.isCart = 0;
        productLocalController.deletProduct(id: item.id ?? 0);
      }
    }
    await productLocalController.getProductList();
    update();
  }
}
