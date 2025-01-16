import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:e_commerce/bloc/Product/index.dart';
import 'package:e_commerce/hive/product.dart';

import '../../data/Apidata.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(super.initialState) {
    on<LoadProductEvent>((event, emit) async {
      emit(const LoadingProductState());
      print("type category: ${event.category}");

      List<Product> products;
      if (event.category != "All") {
        products = await ApiService().getProductsByCategory(event.category);
        developer.log('Loaded products of category ${event.category}: ${products[0].title}', name: 'ProductBloc');
      } else {
        products = await ApiService().getAllProducts().whenComplete(() {});
        developer.log('Loaded all products: ${products[0].title}', name: 'ProductBloc');
      }
      emit(LoadedProductState(products));
    });

    on<LoadingProductEvent>((event, emit) async {
      emit(const LoadingProductState());
      add(LoadProductEvent(category: event.category));
    });

    on<LoadingSingleProductEvent>((event, emit) async {
      emit(LoadingSingleProductState(event.id));
      final product = await ApiService().getProductById(event.id);
      developer.log('Loaded product: ${product.title}', name: 'ProductBloc');
      emit(LoadedSingleProductState(product));
    });
  }
}
