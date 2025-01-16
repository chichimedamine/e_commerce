
import 'package:e_commerce/hive/cart.dart';

import 'package:meta/meta.dart';

import '../../hive/productincart.dart';


@immutable
abstract class CartEvent {}

class UnCartEvent extends CartEvent {}

class LoadCartEvent extends CartEvent {
  final int userId;
  LoadCartEvent({required this.userId});
}

class AddToCartEvent extends CartEvent {
 final Cart cart;
  AddToCartEvent({required this.cart,});
}
class LoadCounterEvent extends CartEvent {}
class RemoveFromCartEvent extends CartEvent {
  final int index;
  RemoveFromCartEvent({required this.index});
}

class UpdateCartEvent extends CartEvent {
  final int cartId;
  final int productId;
  final int quantity;
  UpdateCartEvent(
      {required this.cartId, required this.productId, required this.quantity});
}

class UpdateProductQuantity extends CartEvent {
  final int cartId;
  final List<ProductInCart> products;
  final int productId;
  final int newQuantity;


  UpdateProductQuantity( this.cartId , this.products, this.productId, this.newQuantity );
}
class updateCount extends CartEvent {
  
}