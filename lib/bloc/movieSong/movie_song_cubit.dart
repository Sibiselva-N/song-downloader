import 'package:audiodownload/bloc/movieSong/movie_song_state.dart';
import 'package:audiodownload/repository/movie_song_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieSongCubit extends Cubit<MovieSongState> {
  MovieSongRepository repository;
  MovieSongCubit(this.repository) : super(InitMovieSongState());
  void fetchMovieSong(String mov) async {
    try {
      emit(LoadingMovieSongState());
      final response = await repository.getSong(mov);
      emit(ResponseMovieSongState(response));
    } catch (e) {
      emit(ErrorMovieSongState());
    }
  }
}
