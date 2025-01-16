
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {}

class UnHomeEvent extends HomeEvent {}

class LoadHomeEvent extends HomeEvent {
  String Category;
  int indexCategory ;



  LoadHomeEvent({required this.indexCategory,required this.Category});

}


class LoadingHomeEvent extends HomeEvent {}
