import '../../model/movie_model.dart';

abstract class MovieState {}

class InitMovie extends MovieState {}

class LoadingMovie extends MovieState {}

class ResponseMovie extends MovieState {
  final MovieModel movieModel;
  ResponseMovie(this.movieModel);
}

class ErrorMovie extends MovieState {}
