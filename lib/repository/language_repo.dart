import 'package:dio/dio.dart';

import '../model/language_model.dart';

class LanguageRepository {
  Future<LanguageModel> getLanguage() async {
    Dio dio = Dio();
    Response response = await dio.get("https://songsapi-1.herokuapp.com/");
    LanguageModel languageModel = LanguageModel.fromJson(response.data);
    return languageModel;
  }
}
