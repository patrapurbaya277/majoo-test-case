part of 'register_bloc_cubit.dart';

abstract class RegisterBlocState extends Equatable {
  const RegisterBlocState();

  @override
  List<Object> get props => [];
}

class RegisterBlocInitialState extends RegisterBlocState {}

class RegisterBlocLoadingState extends RegisterBlocState {}

class RegisterBlocErrorState extends RegisterBlocState {
  final error;

  RegisterBlocErrorState(this.error);

  @override
  List<Object> get props => [error];

}

class RegisterBlocSuccessState extends RegisterBlocState {
  final User user;

  RegisterBlocSuccessState(this.user);

  @override
  List<Object> get props => [user];
}
