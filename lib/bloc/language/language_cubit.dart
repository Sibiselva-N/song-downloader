import 'package:audiodownload/bloc/language/language_state.dart';
import 'package:audiodownload/repository/language_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final LanguageRepository _repository;
  LanguageCubit(this._repository) : super(InitLanguage());

  fetchLangugae() async {
    emit(LoadingLanguage());
    try {
      final response = await _repository.getLanguage();
      emit(ResponseLanguage(response));
    } catch (e) {
      emit(ErrorLanguage());
    }
  }
}
