import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/detailspage/details_movie_bloc.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/containers/common_movie_list_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/ui/widgets/details_category_name_widget.dart';

const kSimilarMoviesContainerHeight = 308.0;

class ListSimilarMoviesWidget extends StatefulWidget {
  ListSimilarMoviesWidget(
      {Key? key,
      required this.id,
      required this.listResponseSimilarMovies,
      required this.genresOfSimilarMovie})
      : super(key: key);

  final int id;
  final List<MovieModel>? listResponseSimilarMovies;
  final List<String?> genresOfSimilarMovie;

  @override
  _ListSimilarMoviesWidgetState createState() =>
      _ListSimilarMoviesWidgetState();
}

class _ListSimilarMoviesWidgetState extends State<ListSimilarMoviesWidget> {
  final ScrollController _similarScrollController = ScrollController();

  @override
  void initState() {
    _similarScrollController.addListener(() {
      if (_similarScrollController.position.pixels ==
          _similarScrollController.position.maxScrollExtent) {
        BlocProvider.of<DetailsMovieBloc>(context)
            .add(LoadMoreDetailsPageEvent(id: widget.id));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _similarScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsCategoryNameWidget(
          category: 'Similar movies',
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: kSimilarMoviesContainerHeight,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.listResponseSimilarMovies?.length,
            controller: _similarScrollController,
            itemBuilder: (ctx, index) {
              return CommonMovieListWidget(
                  movieModel: widget.listResponseSimilarMovies?[index]);
            },
          ),
        ),
      ],
    );
  }
}
