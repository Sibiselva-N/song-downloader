import 'package:audiodownload/bloc/download/download_state.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(NotStartedState());
  startDownload(String url, String title) async {
    Dio dio = Dio();
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    try {
      dio.download(url, "/storage/emulated/0/Download/AudioDer/$title.mp3",
          onReceiveProgress: (count, total) {
        String percent = (count / total * 100).toStringAsFixed(0);
        emit(DownloadingState(percent));
      }).then((value) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: title,
              body: "$title has been downloaded on downloads folder",
              actionType: ActionType.Default),
        );
        emit(NotStartedState());
      });
    } catch (e) {
      emit(NotStartedState());
    }
  }
}
