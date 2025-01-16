import 'package:e_commerce/hive/productincart.dart';
import 'package:hive_ce/hive.dart';


class Cart extends HiveObject {
  Cart({
    this.id,
    this.userId,
    this.date,
    this.products,
  });
 int? id;
  int? userId;
  DateTime? date;
  List<ProductInCart>? products;
}