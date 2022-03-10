part of 'detail_bloc_cubit.dart';

abstract class DetailBlocState extends Equatable {
  const DetailBlocState();

  @override
  List<Object> get props => [];
}

class DetailBlocInitialState extends DetailBlocState {}

class DetailBlocLoadingState extends DetailBlocState {}

class DetailBlocErrorState extends DetailBlocState {
  final error;

  DetailBlocErrorState(this.error);

  @override
  List<Object> get props => [error];

}

class DetailBlocSuccessState extends DetailBlocState {
  final MovieDetail data;

  DetailBlocSuccessState(this.data);

  @override
  List<Object> get props => [data];
}
