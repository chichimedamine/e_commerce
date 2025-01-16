import 'package:equatable/equatable.dart';

import '../../hive/cart.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnCartState extends CartState {
  const UnCartState();

  @override
  String toString() => 'UnCartState';
}

/// Initialized
class InCartState extends CartState {
  const InCartState(this.hello);

  final String hello;

  @override
  String toString() => 'InCartState $hello';

  @override
  List<Object> get props => [hello];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  CartLoaded(
    this.count,
    this.data,
    this.totalprice,
  );
  double totalprice;
  int count;

  final List<Cart> data;
}

class CartEmpty extends CartState {}

class ErrorCartState extends CartState {
  const ErrorCartState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorCartState';

  @override
  List<Object> get props => [errorMessage];
}
class CountUpdated extends CartState {
  int count;

  CountUpdated(this.count);
  

}
class CountLoaded extends CartState {
  int count;

  CountLoaded(this.count);
  
}
class CountInitial extends CartState {
 
  CountInitial();
  
}

class CartUpdated extends CartState {
  double totalprice;

  final List<Cart> data;

  CartUpdated(this.data, this.totalprice);
}

