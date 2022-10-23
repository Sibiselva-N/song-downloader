import 'package:audiodownload/bloc/youtube/youtube_state.dart';
import 'package:audiodownload/model/youtube_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeCubit extends Cubit<YoutubeState> {
  YoutubeCubit() : super(InitYtState());
  search(String url) async {
    emit(LoadingYtState());
    List<YtModel> list = [];
    YoutubeExplode yt = YoutubeExplode();
    try {
      var audio = await yt.videos.streams.getManifest(url);
      var t = await yt.videos.get(url);

      var ad = audio.audioOnly;
      for (var i in ad) {
        list.add(YtModel(
          bit: i.bitrate.toString(),
          size: "${i.size.totalMegaBytes.toStringAsFixed(2)} MB",
          url: i.url,
        ));
      }
      emit(SuccessYtState(list: list, title: t.title.toString()));
    } catch (e) {
      emit(FailedYtState());
    }
  }
}
