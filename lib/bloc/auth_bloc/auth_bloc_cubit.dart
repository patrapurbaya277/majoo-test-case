import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/services/sqlite_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_state.dart';

class AuthBlocCubit extends Cubit<AuthBlocState> {
  AuthBlocCubit() : super(AuthBlocInitialState());

  void fetchHistoryLogin() async {
    emit(AuthBlocInitialState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPreferences.getBool("is_logged_in");
    if (isLoggedIn == null) {
      emit(AuthBlocLoginState());
    } else {
      if (isLoggedIn) {
        emit(AuthBlocLoggedInState());
      } else {
        emit(AuthBlocLoginState());
      }
    }
  }

  void loginUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    emit(AuthBlocLoadingState());
    SqliteService sqlService = SqliteService();
    var result = await sqlService.login(user.email, user.password);
    if (result != null) {
      await sharedPreferences.setBool("is_logged_in", true);
      String data = user.toJson().toString();
      sharedPreferences.setString("user_value", data);
      emit(AuthBlocLoggedInState());
    }else{
      emit(AuthBlocErrorState("Login Gagal, periksa kembali inputan anda"));
    }
  }

  void logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    emit(AuthBlocLoginState());
  }
}
