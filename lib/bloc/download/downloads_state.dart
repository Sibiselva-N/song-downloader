import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';

abstract class DownloadsState {}

class InitDownloads extends DownloadsState {}

class LoadingDownloads extends DownloadsState {}

class SuccessDownloads extends DownloadsState {
  List<Audio> list;
  SuccessDownloads({required this.list});
}

class ErrorDownloads extends DownloadsState {}

class PauseState extends DownloadsState {
  int status;
  PauseState({required this.status});
}
