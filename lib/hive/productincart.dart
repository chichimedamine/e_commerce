
import 'package:e_commerce/hive/rating.dart';
import 'package:hive_ce/hive.dart';

class ProductInCart  extends HiveObject {
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

}
