import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/bloc/register_bloc/register_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/ui/register/register_page.dart';

import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _emailController = TextController();
  final _passwordController = TextController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Theme.of(context).primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      body: BlocListener<AuthBlocCubit, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthBlocLoggedInState) {
            _loginSuccess();
          }

          if (state is AuthBlocErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
            // context.read<AuthBlocCubit>().emit(AuthBlocLoginState());
          }
        },
        child: Padding(
          padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Selamat Datang',
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //     // color: colorBlue,
                  //   ),
                  // ),
                  // Text(
                  //   'Silahkan login terlebih dahulu',
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                  _title(),
                  _subTitle(),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    endIndent: MediaQuery.of(context).size.width / 1.2,
                    thickness: 5,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  _form(),
                  SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    text: 'Login',
                    onPressed: handleLogin,
                    // height: 100,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _register(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      "Welcome !",
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _subTitle() {
    return Text(
      "Please fill the form login",
      style: TextStyle(
        fontSize: 15,
        // fontWeight: FontWeight.bold,
      ),
    );
  }

  void _loginSuccess() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Login Berhasil")));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      context.read<HomeBlocCubit>().fetchingData();
      return HomePage();
    }));
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            context: context,
            controller: _emailController,
            isEmail: true,
            hint: 'Example@123.com',
            label: 'Email',
            validator: (val) {
              final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (val != null)
                return pattern.hasMatch(val)
                    ? null
                    : 'Masukkan email yang valid';
              return null;
            },
          ),
          CustomTextFormField(
            context: context,
            label: 'Password',
            hint: 'password',
            controller: _passwordController,
            isObscureText: _isObscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _register() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () async {
          context.read<RegisterBlocCubit>().init();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => RegisterPage()));
        },
        child: RichText(
          text: TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(color: Colors.black45),
              children: [
                TextSpan(
                  text: 'Daftar',
                ),
              ]),
        ),
      ),
    );
  }

  void handleLogin() async {
    final _email = _emailController.value;
    final _password = _passwordController.value;
    if (formKey.currentState?.validate() == true &&
        _email != "" &&
        _password != "") {
      User user = User(
        email: _email,
        password: _password,
      );
      context.read<AuthBlocCubit>().loginUser(user);
    }
  }
}
