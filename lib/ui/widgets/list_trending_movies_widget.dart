import 'package:flutter/material.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/ui/containers/movie_trending_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/bloc/homepage/trending/trending_movie_bloc.dart';

class ListTrendingMoviesWidget extends StatelessWidget {
  ListTrendingMoviesWidget(
      {Key? key,
      required this.numbers,
      required this.listResponse,
      required this.genres})
      : super(key: key);

  final List<int> numbers;
  final ListResponse listResponse;
  final List<String?> genres;

  final ScrollController _trendingScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listResponse.movies?.length,
      controller: _trendingScrollController
        ..addListener(() {
          if (_trendingScrollController.position.pixels ==
              _trendingScrollController.position.maxScrollExtent) {
            print("pageNumberOfTrending ${listResponse.page}");

            BlocProvider.of<TrendingMovieBloc>(context)
                .add(LoadTrendingPageEvent());
          }
        }),
      itemBuilder: (ctx, index) {
        return MovieContainer(
          number: numbers[index],
          movieModel: listResponse.movies?[index],
          genres: genres[index],
        );
      },
    );
  }
}
