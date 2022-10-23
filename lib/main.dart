import 'package:audiodownload/bloc/download/download_cubit.dart';
import 'package:audiodownload/bloc/download/downloads_cubit.dart';
import 'package:audiodownload/bloc/movie/movie_cubit.dart';
import 'package:audiodownload/bloc/movieSong/movie_song_cubit.dart';
import 'package:audiodownload/bloc/youtube/youtube_cubit.dart';
import 'package:audiodownload/constants.dart';
import 'package:audiodownload/repository/language_repo.dart';
import 'package:audiodownload/repository/movie_repo.dart';
import 'package:audiodownload/repository/movie_song_repo.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'bloc/language/language_cubit.dart';
import 'screens/splash_screen.dart';

void main() {
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.red,
          ledColor: Colors.white)
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group')
    ],
  );
  AwesomeNotifications().setListeners(onActionReceivedMethod: (v) async {
    OpenFile.open("/storage/emulated/0/Download/${v.title}.mp3");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit(LanguageRepository())),
        BlocProvider(create: (_) => MovieCubit(MovieRepository())),
        BlocProvider(create: (_) => MovieSongCubit(MovieSongRepository())),
        BlocProvider(create: (_) => DownloadCubit()),
        BlocProvider(create: (_) => YoutubeCubit()),
        BlocProvider(create: (_) => Downloads()),
      ],
      child: MaterialApp(
        navigatorKey: navi,
        home: const SplashScreen(),
      ),
    );
  }
}
