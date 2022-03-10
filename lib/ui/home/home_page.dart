import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/ui/login/login_page.dart';
import 'package:path/path.dart';
import '../../bloc/home_bloc/home_bloc_cubit.dart';
import 'home_loaded.dart';
import '../extra/loading.dart';
import '../extra/error_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Apakah anda yakin ?'),
              content: new Text('Ingin keluar dari aplikasi'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: new Text('Tidak',
                      style: TextStyle(color: Color(0xff00adef))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: new Text('Ya',
                      style: TextStyle(color: Color(0xff00adef))),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocListener<AuthBlocCubit, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthBlocLoginState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          }
        },
        child: BlocBuilder<HomeBlocCubit, HomeBlocState>(
            builder: (context, state) {
          if (state is HomeBlocLoadedState) {
            return HomeLoaded(data: [
              state.nowPlayingList,
              state.popularList,
              state.trendingList
            ]);
          } else if (state is HomeBlocInitialState) {
            return Scaffold();
          } else if (state is HomeBlocErrorState) {
            return ErrorScreen(
              message: state.error,
              retry: () {
                context.read<HomeBlocCubit>().fetchingData();
              },
            );
          }
          return LoadingIndicator();
        }),
      ),
    );
  }
}
