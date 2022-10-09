abstract class DownloadState {}

class NotStartedState extends DownloadState {}

class DownloadingState extends DownloadState {
  String percent;
  DownloadingState(this.percent);
}
