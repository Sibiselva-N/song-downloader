import 'dart:ui';

import 'package:audiodownload/bloc/youtube/youtube_cubit.dart';
import 'package:audiodownload/bloc/youtube/youtube_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/download/download_cubit.dart';
import '../bloc/download/download_state.dart';

class YoutubeScreen extends StatelessWidget {
  const YoutubeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController url = TextEditingController();
    return Scaffold(
      body: BlocBuilder<YoutubeCubit, YoutubeState>(builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: TextField(
                    controller: url,
                    decoration: const InputDecoration(
                        hintText: "Enter youtube url",
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
                state is LoadingYtState
                    ? const CircularProgressIndicator()
                    : MaterialButton(
                        onPressed: () {
                          context.read<YoutubeCubit>().search(url.text);
                        },
                        child: const Icon(Icons.search),
                      )
              ],
            ),
            state is SuccessYtState
                ? Column(
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              state.title,
                              style: const TextStyle(fontSize: 17),
                            ))
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.list.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const Divider(),
                              ListTile(
                                onTap: () => context
                                    .read<DownloadCubit>()
                                    .startDownload(
                                        state.list[index].url.toString(),
                                        state.title),
                                title: Text(state.list[index].bit),
                                subtitle: Text(state.list[index].size),
                                trailing: const Icon(Icons.download),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
                    ],
                  )
                : state is FailedYtState
                    ? const Center(
                        child: Text("Failed to get audio"),
                      )
                    : const SizedBox()
          ],
        );
      }),
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
