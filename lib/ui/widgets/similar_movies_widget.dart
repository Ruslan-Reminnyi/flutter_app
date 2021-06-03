import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/detailspage/details_movie_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_app/ui/widgets/ComingSoonAndSimilarMoviesWidget.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimilarMoviesWidget extends StatelessWidget {
  SimilarMoviesWidget(
      {Key? key,
      required this.context,
      required this.listResponseSimilarMovies,
      required this.genresOfSimilarMovie})
      : super(key: key);

  final BuildContext context;
  final List<MovieModel>? listResponseSimilarMovies;
  final List<String?> genresOfSimilarMovie;

  final ScrollController _similarScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 810),
      height: kSimilarMoviesContainerHeight,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listResponseSimilarMovies?.length,
        controller: _similarScrollController
        ..addListener(() {
          if (_similarScrollController.position.pixels ==
              _similarScrollController.position.maxScrollExtent) {
            BlocProvider.of<DetailsMovieBloc>(context)
                .add(LoadMoreDetailsPageEvent());
          }
        }),
        itemBuilder: (ctx, index) {
          return ComingSoonAndSimilarMoviesWidget(
              movieModel: listResponseSimilarMovies?[index],
              genres: genresOfSimilarMovie[index]);
        },
      ),
    );
  }
}
