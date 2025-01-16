import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnHomeState extends HomeState {

  const UnHomeState();

  @override
  String toString() => 'UnHomeState';
}

class LoadingHomeState extends HomeState {
  
  @override
  String toString() => 'LoadingHomeState';
  
}

class LoadedHomeState extends HomeState {
  List<String> categories;
  String Category;
  int indexCategory;
  LoadedHomeState(this.indexCategory, this.Category, this.categories);
}
/// Initialized
class InHomeState extends HomeState {
  const InHomeState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InHomeState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorHomeState extends HomeState {
  const ErrorHomeState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorHomeState';

  @override
  List<Object> get props => [errorMessage];
}
