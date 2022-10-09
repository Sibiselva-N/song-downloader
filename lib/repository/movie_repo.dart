import 'package:audiodownload/model/movie_model.dart';
import 'package:dio/dio.dart';

class MovieRepository {
  Future<MovieModel> getMovie(String lan) async {
    Dio dio = Dio();
    Response response =
        await dio.get("https://songsapi-1.herokuapp.com/lan?lan=$lan");
    MovieModel movieModel = MovieModel.fromJson(response.data);
    return movieModel;
  }
}
