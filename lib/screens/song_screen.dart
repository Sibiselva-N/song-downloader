import 'package:audiodownload/bloc/download/download_cubit.dart';
import 'package:audiodownload/bloc/movieSong/movie_song_state.dart';
import 'package:audiodownload/bloc/movieSong/movie_song_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/download/download_state.dart';

class SongScreen extends StatefulWidget {
  final String mov;
  const SongScreen({super.key, required this.mov});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<MovieSongCubit>();
      cubit.fetchMovieSong(widget.mov);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<MovieSongCubit, MovieSongState>(
          builder: (context, state) {
            if (state is InitMovieSongState || state is LoadingMovieSongState) {
              return const CircularProgressIndicator();
            } else if (state is ResponseMovieSongState) {
              return ListView.builder(
                itemCount: state.movieSongModel.songs!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Divider(),
                      ListTile(
                        onTap: () => context
                            .read<DownloadCubit>()
                            .startDownload(
                                state.movieSongModel.songs![index].link!,
                                state.movieSongModel.songs![index].name!),
                        trailing: const Icon(Icons.download),
                        title: Text(state.movieSongModel.songs![index].name!),
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            } else {
              return const Text("Error Occured");
            }
          },
        ),
      ),
      floatingActionButton: BlocBuilder<DownloadCubit, DownloadState>(
        builder: (context, state) {
          if (state is DownloadingState) {
            return Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
              child: Text(
                state.percent,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
