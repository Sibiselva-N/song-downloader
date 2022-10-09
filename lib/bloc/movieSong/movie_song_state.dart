import 'package:audiodownload/model/movie_sond_model.dart';

abstract class MovieSongState {}

class InitMovieSongState extends MovieSongState {}

class LoadingMovieSongState extends MovieSongState {}

class ResponseMovieSongState extends MovieSongState {
  MovieSongModel movieSongModel;
  ResponseMovieSongState(this.movieSongModel);
}

class ErrorMovieSongState extends MovieSongState {}
