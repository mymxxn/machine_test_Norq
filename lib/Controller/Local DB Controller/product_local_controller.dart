import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/Model/product_list_model.dart';
import 'package:machine_test/Services/DB%20helper/db_helper.dart';

class ProductLocalController extends GetxController {
  var productList = <ProductListModel>[].obs;
  getProductList() async {
    final List<Map<String, dynamic>> products =
        await DBHelper().fetchProductList();
    productList.assignAll(
        products.map((data) => ProductListModel.fromMap(data)).toList());
    update();
  }

  insertProduct({required ProductListModel product}) async {
    await DBHelper().insertProduct(product: product);
  }

  updateProduct({required int id, required int quantity}) async {
    await DBHelper().updateProduct(id, quantity);
  }

  deletProduct({required int id}) async {
    await DBHelper().deleteProduct(id: id);
  }
}
