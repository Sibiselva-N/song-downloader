import 'package:audiodownload/bloc/language/language_cubit.dart';
import 'package:audiodownload/screens/downloads_screen.dart';
import 'package:audiodownload/screens/youtube_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/language/language_state.dart';
import 'movie_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<LanguageCubit>();
      cubit.fetchLangugae();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            if (state is InitLanguage || state is LoadingLanguage) {
              return const CircularProgressIndicator();
            } else if (state is ResponseLanguage) {
              return Column(
                children: [
                  ListView.builder(
                    itemCount: state.languageModel.language!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const Divider(),
                          ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MovieScreen(
                                        lan: state.languageModel
                                            .language![index].url!))),
                            title: Text(
                                state.languageModel.language![index].language!),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const YoutubeScreen())),
                    title: const Text("Youtube audio download"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const Divider(),
                  const Divider(),
                  ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DownloadsScreen())),
                    title: const Text("Downloads"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const Divider(),
                ],
              );
            } else if (state is ErrorLanguage) {
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
