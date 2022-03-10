import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/services/api_service.dart';

import '../../models/movie_detail.dart';

part 'detail_bloc_state.dart';

class DetailBlocCubit extends Cubit<DetailBlocState> {
  DetailBlocCubit() : super(DetailBlocInitialState());

  void init() {
    emit(DetailBlocInitialState());
  }

  void getDetail(String id, String type) async {
    emit(DetailBlocInitialState());
    emit(DetailBlocLoadingState());
    ApiServices apiServices = ApiServices();
    var result = await apiServices.getDetail(type, id);
    try {
      emit(DetailBlocSuccessState(result!));
    } catch (e) {
      emit(DetailBlocErrorState("Error getting detail"));
    }
  }
}
