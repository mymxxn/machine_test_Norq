import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:machine_test/Controller/cart_controller.dart';
import 'package:machine_test/Model/product_list_model.dart';
import 'package:machine_test/Utils/Constants/app_colors.dart';
import 'package:machine_test/Utils/Constants/asset_paths.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: AppColors.white,
            )),
        title: Text(
          "Cart",
          style: TextStyle(color: AppColors.white),
        ),
        elevation: 100,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.greenPrimary, AppColors.bluePrimary]))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<CartController>(
            builder: (_) => _.cartList.isEmpty
                ? Center(
                    child: Image.asset(
                      AssetIconPath.emptyCart,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  )
                : ListView.builder(
                    itemCount: _.cartList.length,
                    itemBuilder: (context, index) {
                      ProductListModel product = _.cartList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product image
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(AssetImagePath.logo),
                                    product.image ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10), // Spacer

                              // Product details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product title
                                    Text(
                                      "${product.title ?? ''}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 5), // Spacer

                                    // Product price
                                    Text(
                                      "₹${product.price ?? 0.0}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.lightgrey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 5), // Spacer

                                    // Product rating
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating:
                                              product.rating?.rate ?? 0,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          itemSize: 12,
                                          ignoreGestures: true,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        Text(
                                          "(${product.rating?.count ?? 0}}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: AppColors.lightgrey,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5), // Spacer

                                    // Add/Remove buttons
                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            _.addProduct(
                                                item: product, isAdd: false);
                                          },
                                          label: Text("Remove"),
                                        ),
                                        SizedBox(width: 10), // Spacer
                                        Text("${product.quantity ?? 0}"),
                                        SizedBox(width: 10), // Spacer
                                        ElevatedButton.icon(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            _.addProduct(
                                                item: product, isAdd: true);
                                          },
                                          label: Text("Add"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
