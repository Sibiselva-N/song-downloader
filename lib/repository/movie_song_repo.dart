import 'package:audiodownload/model/movie_sond_model.dart';
import 'package:dio/dio.dart';

class MovieSongRepository {
  Future<MovieSongModel> getSong(String mov) async {
    Dio dio = Dio();
    Response response =
        await dio.get("https://songsapi-1.herokuapp.com/mov?mov=$mov");
    MovieSongModel movieSongModel = MovieSongModel.fromJson(response.data);
    return movieSongModel;
  }
}
