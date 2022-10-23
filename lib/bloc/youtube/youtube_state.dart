import 'package:audiodownload/model/youtube_model.dart';

abstract class YoutubeState {}

class InitYtState extends YoutubeState {}

class LoadingYtState extends YoutubeState {}

class SuccessYtState extends YoutubeState {
  List<YtModel> list;
  String title;
  SuccessYtState({required this.list, required this.title});
}

class FailedYtState extends YoutubeState {}
