import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/services/sqlite_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        emit(RegisterBlocErrorState("Akun sudah terdaftar. Gunakan email dan username yang berbeda"));
      }
    } catch (e) {}
  }
}
