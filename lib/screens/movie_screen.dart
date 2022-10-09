import 'package:audiodownload/bloc/movie/movie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movie/movie_cubit.dart';
import 'song_screen.dart';

class MovieScreen extends StatefulWidget {
  final String lan;
  const MovieScreen({super.key, required this.lan});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<MovieCubit>();
      cubit.fetchMovie(widget.lan);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<MovieCubit, MovieState>(builder: (context, state) {
          if (state is InitMovie || state is LoadingMovie) {
            return const CircularProgressIndicator();
          } else if (state is ResponseMovie) {
            return ListView.builder(
              itemCount: state.movieModel.mlist!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const Divider(),
                    ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SongScreen(
                                  mov: state.movieModel.mlist![index].link!))),
                      title: Text(state.movieModel.mlist![index].title!),
                      leading: Image.network(
                        state.movieModel.mlist![index].image!,
                        width: 50,
                        height: 100,
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          } else {
            return const Text("Error Occured");
          }
        }),
      ),
      floatingActionButton: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is ResponseMovie) {
            return MaterialButton(
              onPressed: () {
                final cubit = context.read<MovieCubit>();
                cubit.fetchMovie(state.movieModel.next!);
              },
              color: Colors.red,
              child: const Text(
                "Load Next 10",
                style: TextStyle(color: Colors.white),
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
