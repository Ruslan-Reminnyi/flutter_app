import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/detailspage/details_movie_bloc.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/common_movie_list_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/ui/widgets/details_category_name_widget.dart';

class ListSimilarMoviesWidget extends StatelessWidget {
  ListSimilarMoviesWidget(
      {Key? key,
      required this.id,
      required this.listResponseSimilarMovies,
      required this.genresOfSimilarMovie})
      : super(key: key);

  final int id;
  final List<MovieModel>? listResponseSimilarMovies;
  final List<String?> genresOfSimilarMovie;

  final ScrollController _similarScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsCategoryNameWidget(
          category: 'Similar movies',
        ),
        SizedBox(
          height: 5,
        ),
        Container(
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
                      .add(LoadMoreDetailsPageEvent(id: id));
                }
              }),
            itemBuilder: (ctx, index) {
              return CommonMovieListWidget(
                  movieModel: listResponseSimilarMovies?[index],
                  genres: genresOfSimilarMovie[index]);
            },
          ),
        ),
      ],
    );
  }
}
