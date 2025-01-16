// To parse this JSON data, do
//
//     final cartUser = cartUserFromJson(jsonString);

import 'dart:convert';

CartUser cartUserFromJson(String str) => CartUser.fromJson(json.decode(str));

String cartUserToJson(CartUser data) => json.encode(data.toJson());

class CartUser {
  int? id;
  int? userId;
  DateTime? date;
  List<ProductCart>? products;
  int? v;

  CartUser({
    this.id,
    this.userId,
    this.date,
    this.products,
    this.v,
  });

  factory CartUser.fromJson(Map<String, dynamic> json) {
    print("data all ${json["products"]}  ${json["date"]} ");
    return CartUser(
      id: json["id"],
      userId: json["userId"],
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      products: json["products"] == null
          ? []
          : List<ProductCart>.from(
              json["products"]!.map((x) => ProductCart.fromJson(x))),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date?.toIso8601String(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "__v": v,
      };
}

class ProductCart {
  int? productId;
  int? quantity;

  ProductCart({
    this.productId,
    this.quantity,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}
