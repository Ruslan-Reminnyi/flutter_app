import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/detailspage/details_movie_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/movie_list_widget.dart';
import 'package:flutter_app/ui/widgets/details_category_name_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kSimilarMoviesContainerHeight = 308.0;

class ListSimilarMoviesWidget extends StatelessWidget {
  ListSimilarMoviesWidget(
      {Key? key,
      required this.id,
      required this.listResponseSimilarMovies,
      this.padding = EdgeInsets.zero,
        required this.sessionId})
      : super(key: key);

  final int id;
  final List<MovieModel>? listResponseSimilarMovies;
  final EdgeInsets padding;
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: DetailsCategoryNameWidget(
            category: 'Similar movies',
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: kSimilarMoviesContainerHeight,
          child: MovieList(
            padding: padding,
            movies: listResponseSimilarMovies,
            loadMore: () {
              BlocProvider.of<DetailsMovieBloc>(context)
                  .add(LoadMoreDetailsPageEvent(id: id));
            },
            sessionId: sessionId,
          ),
        ),
      ],
    );
  }
}
