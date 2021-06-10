import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/listview_widget.dart';
import 'package:flutter_app/ui/widgets/details_category_name_widget.dart';

const kSimilarMoviesContainerHeight = 308.0;

class ListSimilarMoviesWidget extends StatelessWidget {
  ListSimilarMoviesWidget(
      {Key? key,
      required this.id,
      required this.listResponseSimilarMovies,
      this.padding = EdgeInsets.zero})
      : super(key: key);

  final int id;
  final List<MovieModel>? listResponseSimilarMovies;
  final EdgeInsets padding;

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
          child: ListviewWidget(
            padding: padding,
            listMovieModel: listResponseSimilarMovies,
            kindOfWidget: KindOfWidget.similar,
            id: id,
          ),
        ),
      ],
    );
  }
}
