part of 'home_bloc_cubit.dart';

abstract class HomeBlocState extends Equatable {
  const HomeBlocState();

  @override
  List<Object> get props => [];
}

class HomeBlocInitialState extends HomeBlocState {}

class HomeBlocLoadingState extends HomeBlocState {}

class HomeBlocLoadedState extends HomeBlocState {
  final List<Movie> nowPlayingList;
  final List<Movie> popularList;
  final List<Movie> trendingList;

  HomeBlocLoadedState(
    this.nowPlayingList,
    this.popularList,
    this.trendingList,
  );
  @override
  List<Object> get props => [
        nowPlayingList,
        popularList,
        trendingList,
      ];
}

class HomeBlocErrorState extends HomeBlocState {
  final error;

  HomeBlocErrorState(this.error);

  @override
  List<Object> get props => [error];
}
