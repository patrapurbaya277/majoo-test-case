import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/movie.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/services/api_service.dart';

part 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> {
  HomeBlocCubit() : super(HomeBlocInitialState());

  void fetchingData() async {
    emit(HomeBlocLoadingState());
    try {
      MovieResponse? popular, nowPlaying, trending;
      popular = await fetchNowPlaying();
      nowPlaying = await fetchPopular();
      trending = await fetchTrending();
      if (popular != null && nowPlaying != null && trending!=null) {
        emit(HomeBlocLoadedState(nowPlaying.results!, popular.results!, trending.results!));
      } else {
        emit(HomeBlocErrorState("Error Unknown"));
      }
    } catch (e) {
      emit(HomeBlocErrorState("Error Unknown"));
    }
  }

  Future<MovieResponse?> fetchNowPlaying() async {
    ApiServices apiServices = ApiServices();
    MovieResponse? movieResponse = await apiServices.getNowPlayingMovies();
    if (movieResponse == null) {
      // emit(HomeBlocErrorState("Error Unknown"));
      return null;
    } else {
      // emit(HomeBlocLoadedState(movieResponse.results!));
      return movieResponse;
    }
  }

  Future<MovieResponse?> fetchTrending() async {
    ApiServices apiServices = ApiServices();
    MovieResponse? movieResponse = await apiServices.getTrending();
    if (movieResponse == null) {
      // emit(HomeBlocErrorState("Error Unknown"));
      return null;
    } else {
      // emit(HomeBlocLoadedState(movieResponse.results!));
      return movieResponse;
    }
  }

  Future<MovieResponse?> fetchPopular() async {
    ApiServices apiServices = ApiServices();
    MovieResponse? movieResponse = await apiServices.getPopularMovies();
    if (movieResponse == null) {
      // emit(HomeBlocErrorState("Error Unknown"));
      return null;
    } else {
      // emit(HomeBlocLoadedState(movieResponse.results!));
      return movieResponse;
    }
  }
}
