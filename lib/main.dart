import 'package:majootestcase/ui/login/login_page.dart';
import 'bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/detail_bloc/detail_bloc_cubit.dart';
import 'bloc/home_bloc/home_bloc_cubit.dart';
import 'package:flutter/material.dart';
import 'bloc/register_bloc/register_bloc_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBlocCubit>(
          create: (BuildContext context) =>
              AuthBlocCubit()..fetchHistoryLogin(),
        ),
        BlocProvider<HomeBlocCubit>(
          create: (BuildContext context) => HomeBlocCubit(),
        ),
        BlocProvider<RegisterBlocCubit>(
          create: (BuildContext context) => RegisterBlocCubit(),
        ),
        BlocProvider<DetailBlocCubit>(
          create: (BuildContext context) => DetailBlocCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Majoo Test Case',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: LoginPage(),
      ),
    );
  }
}
