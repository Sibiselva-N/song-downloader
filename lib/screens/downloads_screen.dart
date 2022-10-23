import 'package:audiodownload/bloc/download/download_cubit.dart';
import 'package:audiodownload/bloc/download/downloads_cubit.dart';
import 'package:audiodownload/bloc/download/downloads_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<Downloads>();
      cubit.getall();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<Downloads, DownloadsState>(
          builder: (context, state) {
            if (state is InitDownloads || state is LoadingDownloads) {
              return const CircularProgressIndicator();
            } else if (state is SuccessDownloads) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          context.read<Downloads>().playAll(state.list);
                        },
                        color: Colors.green,
                        child: const Text(
                          "Play All",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    itemCount: state.list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const Divider(),
                          ListTile(
                            onTap: () => context
                                .read<Downloads>()
                                .play(state.list[index], index),
                            title: Text(state.list[index].metas.title!),
                            trailing:
                                context.watch<Downloads>().playState(index)
                                    ? const Icon(Icons.pause)
                                    : const Icon(Icons.play_arrow),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ],
              );
            } else if (state is ErrorDownloads) {
              return const Center(
                child: Text("Error Occured"),
              );
            }
            return Text(state.toString());
          },
        ),
      ),
    );
  }
}
