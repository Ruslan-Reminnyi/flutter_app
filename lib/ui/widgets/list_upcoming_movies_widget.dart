import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/homepage/upcoming/upcoming_movie_bloc.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/ui/containers/movie_coming_soon_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUpcomingMoviesWidget extends StatelessWidget {
  ListUpcomingMoviesWidget(
      {Key? key, required this.listResponse, required this.genres})
      : super(key: key);

  final ListResponse listResponse;
  final List<String?> genres;

  final ScrollController _upcomingScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listResponse.movies?.length,
      controller: _upcomingScrollController
        ..addListener(() {
          if (_upcomingScrollController.position.pixels ==
              _upcomingScrollController.position.maxScrollExtent) {
            print("pageNumberOfUpcoming ${listResponse.page! + 1}");

            BlocProvider.of<UpcomingMovieBloc>(context)
                .add(LoadUpcomingPageEvent(listResponse.page! + 1));
          }
          if (_upcomingScrollController.position.pixels ==
                  _upcomingScrollController.position.minScrollExtent &&
              listResponse.page != 1) {
            print("pageNumberOfUpcoming ${listResponse.page! - 1}");

            BlocProvider.of<UpcomingMovieBloc>(context)
                .add(LoadUpcomingPageEvent(listResponse.page! - 1));
          }
        }),
      itemBuilder: (ctx, index) {
        return MovieComingSoonContainer(
          movieModel: listResponse.movies?[index],
          genres: genres[index],
        );
      },
    );
  }
}
