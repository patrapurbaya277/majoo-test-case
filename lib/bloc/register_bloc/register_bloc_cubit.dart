import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/services/sqlite_service.dart';

part 'register_bloc_state.dart';

class RegisterBlocCubit extends Cubit<RegisterBlocState> {
  RegisterBlocCubit() : super(RegisterBlocInitialState());

  void init() {
    emit(RegisterBlocInitialState());
  }

  void register(User user) async {
    emit(RegisterBlocLoadingState());
    SqliteService sqliteService = SqliteService();

    try {
      var result = await sqliteService.insertUser(user);
      if (result != null) {
        emit(RegisterBlocSuccessState(user));
      } else {
        emit(RegisterBlocErrorState("Account already registered. Insert different email and username"));
      }
    } catch (e) {}
  }
}
