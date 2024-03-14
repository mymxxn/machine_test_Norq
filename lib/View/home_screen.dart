import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:machine_test/Controller/home_controller.dart';
import 'package:machine_test/Model/product_list_model.dart';
import 'package:machine_test/Utils/Constants/app_colors.dart';
import 'package:machine_test/Utils/Constants/asset_paths.dart';
import 'package:machine_test/Utils/Routes/route_manager.dart';
import 'package:machine_test/Utils/shared%20preferences/shared_preferences.dart';
import 'package:machine_test/View/cart_screen.dart';
import 'package:machine_test/View/componant.dart';
import 'package:machine_test/View/item_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                UserPreferences.setIsLoggedIn(false);
                Get.offAllNamed(RouteManager.signInScreen);
              },
              child: Icon(Icons.logout, color: AppColors.white)),
          title: Text(
            "Norq",
            style: TextStyle(color: AppColors.white),
          ),
          elevation: 100,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                AppColors.greenPrimary,
                AppColors.bluePrimary
              ]))),
          actions: [
            InkWell(
              onTap: () => Get.toNamed(RouteManager.cartScreen),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  AssetIconPath.cart,
                  height: 24,
                  color: AppColors.white,
                ),
              ),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<HomeController>(builder: (_) {
          return _.isLoading.value
              ? Components.productShimmer()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 1, // Spacing between columns
                    mainAxisSpacing: 5, // Spacing between rows
                    childAspectRatio: 0.75, // Aspect ratio (width / height)
                  ),
                  itemCount: homeController.productList.length,
                  itemBuilder: (context, index) {
                    ProductListModel product =
                        homeController.productList[index];
                    return InkWell(
                      onTap: () =>
                          Get.to(() => ProductDetailScreen(product: product)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(AssetImagePath.logo),
                                  product.image!,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 250,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black26,
                                          // Colors.black38,
                                          Colors.black54,
                                          Colors.black87,
                                          Colors.black
                                        ]),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${product.title ?? ''}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "₹${product.price ?? 0.0}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.lightgrey,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            RatingBar.builder(
                                              initialRating:
                                                  product.rating?.rate ?? 0,
                                              minRating: 0,
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              itemSize: 8,
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
                                                  color: AppColors.white),
                                            )
                                          ],
                                        ),
                                        product.quantity == 0
                                            ? SizedBox(
                                                height: 28,
                                                width: 88,
                                                child: ElevatedButton.icon(
                                                  icon: SvgPicture.asset(
                                                    AssetIconPath.cart,
                                                    height: 15,
                                                  ),
                                                  onPressed: () {
                                                    _.addProduct(
                                                        item: product,
                                                        isAdd: true);
                                                  },
                                                  label: Text(
                                                    "Add",
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ))
                                            : Container(
                                                height: 28,
                                                width: 88,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: AppColors.white),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () => _.addProduct(
                                                          item: product,
                                                          isAdd: false),
                                                      child: Icon(
                                                        Icons.remove_outlined,
                                                        size: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                    ),
                                                    Text(
                                                        "${product.quantity ?? 0}"),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                    ),
                                                    InkWell(
                                                      onTap: () => _.addProduct(
                                                          item: product,
                                                          isAdd: true),
                                                      child: Icon(
                                                        Icons.add_rounded,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
        }),
      ),
    );
  }
}
