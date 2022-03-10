import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/register_bloc/register_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';

import '../../common/widget/text_form_field.dart';
import '../../models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final _emailController = TextController();
  final _passwordController = TextController();
  final _usernameController = TextController();
  final _emailFocus = FocusNode();
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBlocCubit, RegisterBlocState>(
      listener: (context, state) {
        if (state is RegisterBlocErrorState) {
          _registerError(state);
        }
        if (state is RegisterBlocSuccessState) {
          _registerSuccess(state);
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: _unfocus,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, bottom: 25, right: 25),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _backButton(),
                    SizedBox(
                      height: 50,
                    ),
                    _title(),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      endIndent: MediaQuery.of(context).size.width / 1.2,
                      thickness: 5,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    _form(),
                    SizedBox(height: 50),
                    CustomButton(
                      // height: 100,
                      width: MediaQuery.of(context).size.width,
                      text: "Register",
                      onPressed: _handleRegister,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _unfocus() {
    _emailFocus.unfocus();
    _usernameFocus.unfocus();
    _passwordFocus.unfocus();
  }

  void _registerSuccess(state) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Register Berhasil"),
    ));
    Navigator.pop(context);
    context.read<AuthBlocCubit>().loginUser(state.user);
  }

  void _registerError(state) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(state.error),
    ));
  }

  Widget _backButton() {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
          ),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return Text(
      "Create New Account",
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _handleRegister() {
    final _email = _emailController.value;
    final _password = _passwordController.value;
    final _username = _usernameController.value;
    if (formKey.currentState?.validate() == true &&
        _email != "" &&
        _password != "" &&
        _username != "") {
      User user = User(
        email: _email,
        password: _password,
        username: _username,
      );
      context.read<RegisterBlocCubit>().register(user);
    }
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
            focusNode: _emailFocus,
            hint: 'Example@123.com',
            label: 'Email',
            validator: (val) {
              final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (val != null)
                return pattern.hasMatch(val) ? null : 'email is invalid';
              return null;
            },
          ),
          CustomTextFormField(
            focusNode: _usernameFocus,
            context: context,
            controller: _usernameController,
            hint: 'username',
            label: 'username',
          ),
          CustomTextFormField(
            focusNode: _passwordFocus,
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
}
