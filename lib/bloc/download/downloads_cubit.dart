import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audiodownload/bloc/download/downloads_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class Downloads extends Cubit<DownloadsState> {
  Downloads() : super(InitDownloads());
  int? current;
  getall() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    emit(LoadingDownloads());

    try {
      Directory dir = Directory('/storage/emulated/0/Download/AudioDer/');
      List<FileSystemEntity> files;
      List<FileSystemEntity> songs = [];
      List<Audio> list = [];
      files = dir.listSync(recursive: true, followLinks: false);
      for (FileSystemEntity entity in files) {
        String path = entity.path;
        if (path.endsWith('.mp3')) {
          songs.add(entity);
          list.add(Audio.file(path,
              metas: Metas(
                title: path.split('/').last.replaceAll('.mp3', ''),
              )));
        }
      }
      emit(SuccessDownloads(list: list));
    } catch (e) {
      emit(ErrorDownloads());
    }
  }

  AssetsAudioPlayer ap = AssetsAudioPlayer();
  play(Audio audio, int index) {
    ap.stop();
    current = index;
    ap
        .open(
          audio,
          showNotification: true,
        )
        .whenComplete(() => current = null);
  }

  playAll(List<Audio> audio) {
    ap.stop();
    ap
        .open(
            Playlist(
              audios: audio,
            ),
            showNotification: true,
            loopMode: LoopMode.playlist)
        .whenComplete(() => current = null);
  }

  bool playState(int index) {
    if (current != null) {
      if (current == index) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
