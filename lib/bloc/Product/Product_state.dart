import 'package:e_commerce/hive/product.dart';
import 'package:equatable/equatable.dart';



abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
///
class UnProductState extends ProductState {
  const UnProductState();

  @override
  String toString() => 'UnProductState';
}

class LoadingProductState extends ProductState {
  const LoadingProductState();

  @override
  String toString() => 'LoadingProductState';
}

class LoadedProductState extends ProductState {
  List<Product> Products;
  LoadedProductState(this.Products);
}

class LoadingSingleProductState extends ProductState {
  int id;
  LoadingSingleProductState(this.id);
  
}

class LoadedSingleProductState extends ProductState {
  
  Product product;
  LoadedSingleProductState(this.product);
}

/// Initialized
class InProductState extends ProductState {
  const InProductState(this.hello);

  final String hello;

  @override
  String toString() => 'InProductState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorProductState extends ProductState {
  const ErrorProductState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorProductState';

  @override
  List<Object> get props => [errorMessage];
}
