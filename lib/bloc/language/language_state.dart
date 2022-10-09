import 'package:audiodownload/model/language_model.dart';

abstract class LanguageState {}

class InitLanguage extends LanguageState {}

class LoadingLanguage extends LanguageState {}

class ResponseLanguage extends LanguageState {
  final LanguageModel languageModel;
  ResponseLanguage(this.languageModel);
}

class ErrorLanguage extends LanguageState {}
