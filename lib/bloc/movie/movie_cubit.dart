import 'package:audiodownload/bloc/movie/movie_state.dart';
import 'package:audiodownload/repository/movie_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository repository;
  MovieCubit(this.repository) : super(InitMovie());
  void fetchMovie(String lan) async {
    try {
      emit(LoadingMovie());
      final response = await repository.getMovie(lan);
      emit(ResponseMovie(response));
    } catch (e) {
      emit(ErrorMovie());
    }
  }
}
