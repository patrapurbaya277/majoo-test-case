import 'package:flutter/services.dart';
import 'package:majootestcase/ui/login/login_page.dart';
import 'package:flutter/foundation.dart';
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
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   home: BlocProvider(
    //     create: (context) =>
    //     AuthBlocCubit(
    //     )
    //       ..fetchHistoryLogin(),
    //     child: MyHomePageScreen(),
    //   ),
    // );

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
        title: 'Pikunikku',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: LoginPage(),
      ),
    );
  }
}

// class MyHomePageScreen extends StatelessWidget {
//   const MyHomePageScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBlocCubit, AuthBlocState>(
//         builder: (context, state)
//         {
//           if(state is AuthBlocLoginState)
//           {
//             return LoginPage();
//           }
//           else if(state is AuthBlocLoggedInState)
//           {
//             return BlocProvider(
//               create: (context) =>
//               HomeBlocCubit(
//               )
//                 ..fetchingData(),
//               child: HomeBlocScreen(),
//             );
//           }

//           return Center(child: Text(
//               kDebugMode?"state not implemented $state": ""
//           ));
//         });
//   }
// }

