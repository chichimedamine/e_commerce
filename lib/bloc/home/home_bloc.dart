import 'package:bloc/bloc.dart';
import 'package:e_commerce/bloc/home/index.dart';

import '../../data/Apidata.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    on<LoadHomeEvent>((event, emit) async {
     // emit(LoadingHomeState());
      final categories = await ApiService().getCategories().whenComplete(() {});

      emit(LoadedHomeState(event.indexCategory, event.Category, categories));
    });

    on<LoadingHomeEvent>((event, emit) async {
      emit(LoadingHomeState());

    
    });
  }
}
