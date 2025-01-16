import 'package:e_commerce/models/rating.dart';

class ProductInCart {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;
  int? quantity;
  double? totalPrice;
  int cartId;

  ProductInCart(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating,
      this.quantity = 1,
      this.totalPrice ,
      this.cartId = 1});

  factory ProductInCart.fromJson(Map<String, dynamic> json) {
    return ProductInCart(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }
}
