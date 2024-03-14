// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

List<ProductListModel> productListModelFromJson(String str) =>
    List<ProductListModel>.from(
        json.decode(str).map((x) => ProductListModel.fromJson(x)));

String productListModelToJson(List<ProductListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductListImportantNames {
  static const String tableName = 'ProductTable';
  static const String id = 'id';
  static const String title = 'title';
  static const String price = 'price';
  static const String description = 'description';
  static const String category = 'category';
  static const String image = 'image';
  static const String rating = 'rating';
  static const String quantity = 'quantity';
  static const String isCart = 'isCart';
}

class ProductListModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  RatingModel? rating;
  int? quantity;
  int? isCart;

  ProductListModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating,
      this.quantity,
      this.isCart});

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: RatingModel.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating?.toJson(),
      };
  Map<String, dynamic> toMap() {
    return {
      ProductListImportantNames.id: id,
      ProductListImportantNames.title: title,
      ProductListImportantNames.price: price,
      ProductListImportantNames.description: description,
      ProductListImportantNames.category: category,
      ProductListImportantNames.image: image,
      ProductListImportantNames.rating: rating,
      ProductListImportantNames.quantity: quantity,
      ProductListImportantNames.isCart: isCart
    };
  }

  ProductListModel.fromMap(Map<String, dynamic> map) {
    id = map[ProductListImportantNames.id];
    title = map[ProductListImportantNames.title];
    price = map[ProductListImportantNames.price];
    description = map[ProductListImportantNames.description];
    category = map[ProductListImportantNames.category];
    image = map[ProductListImportantNames.image];
    rating = map[ProductListImportantNames.rating];
    quantity = map[ProductListImportantNames.quantity];
    isCart = map[ProductListImportantNames.isCart];
  }
}

class RatingImportantNames {
  static const String tableName = 'RatingTable';
  static const String id = 'id';
  static const String rate = 'rate';
  static const String count = 'count';
}

class RatingModel {
  int? id;
  double? rate;
  int? count;

  RatingModel({
    this.id,
    this.rate,
    this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
  Map<String, dynamic> toMap() {
    return {
      RatingImportantNames.id: id,
      RatingImportantNames.rate: rate,
      RatingImportantNames.count: count
    };
  }

  RatingModel.fromMap(Map<String, dynamic> map) {
    id = map[RatingImportantNames.id];
    rate = map[RatingImportantNames.rate];
    count = map[RatingImportantNames.count];
  }
}
