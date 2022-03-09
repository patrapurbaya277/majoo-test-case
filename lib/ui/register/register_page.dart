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

  bool _isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBlocCubit, RegisterBlocState>(
      listener: (context, state) {
        if (state is RegisterBlocErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
        if (state is RegisterBlocSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Register Berhasil"),
          ));
          Navigator.pop(context);
          context.read<AuthBlocCubit>().loginUser(state.user);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
            child: Column(
              children: [
                _form(),
                SizedBox(height: 50),
                CustomButton(
                  height: 100,
                  text: "Register",
                  onPressed: _handleRegister,
                )
              ],
            ),
          ),
        ),
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
            context: context,
            controller: _usernameController,
            hint: 'username',
            label: 'username',
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
}
