import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/Controller/home_controller.dart';
import 'package:machine_test/Model/product_list_model.dart';
import 'package:machine_test/Utils/Constants/app_colors.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({Key? key, required this.product}) : super(key: key);
  final ProductListModel product;
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product image
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.image ?? ""),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Product name
              Text(
                product.title ?? "",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Product price
              Text(
                "₹${product.price ?? 0.0}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 5),

              // Product description
              Text(
                product.description ?? "",
                style: TextStyle(fontSize: 15, color: AppColors.darkgrey),
              ),
              SizedBox(
                height: 10,
              ),
              // Add to Cart button
              product.quantity == 0
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add to cart functionality
                        },
                        child: Text("Add to Cart"),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 28,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => homeController.addProduct(
                                  item: product, isAdd: false),
                              child: Icon(
                                Icons.remove_outlined,
                                size: 15,
                              ),
                            ),
                            Text(
                              "|",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w100),
                            ),
                            Text("${product.quantity ?? 0}"),
                            Text(
                              "|",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w100),
                            ),
                            InkWell(
                              onTap: () => homeController.addProduct(
                                  item: product, isAdd: true),
                              child: Icon(
                                Icons.add_rounded,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
