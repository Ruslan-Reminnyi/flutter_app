import 'package:flutter/material.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/ui/containers/movie_trending_container.dart';

class ListTrendingMoviesWidget extends StatelessWidget {
  ListTrendingMoviesWidget(
      {required this.numbers,
      required this.listResponse,
      required this.genres,
      required this.taglines});

  final List<int> numbers;
  final ListResponse listResponse;
  final List<String?> genres;
  final List<String?> taglines;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listResponse.movies?.length,
        itemBuilder: (ctx, index) {
          return MovieContainer(
            number: numbers[index],
            movieModel: listResponse.movies?[index],
            genres: genres[index],
            tagline: taglines[index],
          );
        },
      ),
    );
  }
}
