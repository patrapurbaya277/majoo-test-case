import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/movie.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/services/api_service.dart';
import 'package:majootestcase/services/sqlite_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/movie_detail.dart';

part 'detail_bloc_state.dart';

class DetailBlocCubit extends Cubit<DetailBlocState> {
  DetailBlocCubit() : super(DetailBlocInitialState());

  void init() {
    emit(DetailBlocInitialState());
  }

  void getDetail(String id, String type) async {
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
