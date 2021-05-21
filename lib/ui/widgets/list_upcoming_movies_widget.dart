import 'package:flutter/material.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/ui/containers/movie_coming_soon_container.dart';

class ListUpcomingMoviesWidget extends StatelessWidget {
  ListUpcomingMoviesWidget({required this.listResponse, required this.genres});

  final ListResponse listResponse;
  final List<String?> genres;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listResponse.movies?.length,
        itemBuilder: (ctx, index) {
          return MovieComingSoonContainer(
            movieModel: listResponse.movies?[index],
            genres: genres[index],
          );
        },
      ),
    );
  }
}
