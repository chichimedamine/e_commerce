import 'package:meta/meta.dart';

@immutable
abstract class ProductEvent {
  
}

class UnProductEvent extends ProductEvent {}

class LoadProductEvent extends ProductEvent {
  String category;
  LoadProductEvent({required this.category});
}

class LoadingProductEvent extends ProductEvent {
  String category;
  LoadingProductEvent({required this.category});
}


class LoadingSingleProductEvent extends ProductEvent {
  int id;
  LoadingSingleProductEvent({required this.id});
}

class LoadSingleProductEvent extends ProductEvent {
  int id;
  LoadSingleProductEvent({required this.id});
}