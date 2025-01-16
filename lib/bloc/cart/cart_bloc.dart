import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:e_commerce/bloc/cart/index.dart';
import 'package:e_commerce/data/Apidata.dart';
import 'package:hive_ce/hive.dart';

import '../../hive/cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(super.initialState) {
    on<LoadCounterEvent>((event, emit) async {
      developer.log('LoadCounterEvent');
      final box = await Hive.openBox<Cart>('cart');
      int count = 0;
      if (box.isNotEmpty) {
        final List<Cart> data = box.values.toList();
        count = data.length;
      }
      emit(CountUpdated(count));
    });
    on<LoadCartEvent>((event, emit) async {
      emit(const UnCartState());
      int count = 0;
      final box = await Hive.openBox<Cart>('cart');

      double totalPrice = 0;

      if (box.isNotEmpty) {
        final List<Cart> data = box.values.toList();
        count = data.length;
        for (var element in data) {
          for (var p in element.products!) {
            totalPrice += p.price;
          }
        }

        emit(CartLoaded(count, data, totalPrice));
      } else {
        emit(CartEmpty());
      }

      /*  developer.log('LoadCartEvent');
      final cart = ApiService().getUserCarts(event.userId);
      final List<CartUser> cartItems = [];
      double totalPrice = 0;
      final List<ProductInCart> products = [];
      await cart.then((value) => cartItems.addAll(value));

      for (var element in cartItems) {
        print("ddd ${element.id} ${element.products}");

        for (var p in element.products!) {
          final product = ApiService().getProductByIdCart(p.productId!);
          await product.then((value) {
            value.cartId = element.id!;
            value.totalPrice = (value.price * p.quantity!);
            totalPrice += value.totalPrice!;
            value.quantity = p.quantity!;
            products.add(value);
          });
        }
      }

      emit(CartLoaded( products, totalPrice));
      print("List Product cart $products");*/
    });

    on<AddToCartEvent>((event, emit) async {
      developer.log('AddToCartEvent');
      final box = await Hive.openBox<Cart>('cart');
      await box.add(event.cart);
      add(LoadCartEvent(userId: 1));
      /*  await ApiService().addToCart(event.userId, event.productId);
      final cart = ApiService().getUserCarts(1);
      final List<CartUser> cartItems = [];
      /* cart.then((value) => cartItems.addAll(value));
      emit(CartLoaded(cartItem ,products));*/*/
    });
    on<UpdateCartEvent>((event, emit) async {
      developer.log('UpdateCartEvent');
      await ApiService()
          .updateCart(event.cartId, event.productId, event.quantity)
          .whenComplete(() {
        add(LoadCartEvent(userId: 1));
      });
    });
    on<UpdateProductQuantity>((event, emit) async {
      emit(CartInitial());
      developer.log('UpdateProductQuantity');
      double newTotalPrice = 0;
      final box = await Hive.openBox<Cart>('cart');

      if (box.isNotEmpty) {
        final List<Cart> data = box.values.toList();
        for (var element in data) {
          for (var p in element.products!) {
            if (p.id == event.productId && p.cartId == event.cartId) {
              p.quantity = event.newQuantity;
              p.totalPrice = p.quantity! * p.price;
              newTotalPrice += p.totalPrice!;
            } else {
              p.totalPrice = p.quantity! * p.price;
              newTotalPrice += p.totalPrice!;
            }
          }
        }
        emit(CartUpdated(data, newTotalPrice));

        /* for (var product in event.products) {
        if (product.id == event.productId && product.cartId == event.cartId) {
          print("before ${product.quantity}");
          product.quantity = event.newQuantity;
          print("after ${product.quantity}");

          product.totalPrice = product.quantity! * product.price;
          newTotalPrice += product.totalPrice!;
        } else {
          newTotalPrice += product.totalPrice!;
        }
      }*/
      }
    });
    on<RemoveFromCartEvent>((event, emit) async {
      developer.log('DeleteCartEvent');

      final box = await Hive.openBox<Cart>('cart');
      await box.deleteAt(event.index);
      int count = 0;

      double totalPrice = 0;

      if (box.isNotEmpty) {
        final List<Cart> data = box.values.toList();
        count = data.length;
        for (var element in data) {
          for (var p in element.products!) {
            totalPrice += p.price;
          }
          add(LoadCartEvent(userId: 1));
        }
      }else{
       emit(CartEmpty());
      }

      
    });
    on<updateCount>((event, emit) async {
      developer.log('updateCount');
      emit(CartInitial());
      int count = 0;
      final box = await Hive.openBox<Cart>('cart');

      if (box.isNotEmpty) {
        final List<Cart> data = box.values.toList();
        count = data.length;
      }
      emit(CountUpdated(count));
    });
  }
}
