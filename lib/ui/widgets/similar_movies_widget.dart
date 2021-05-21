import 'package:flutter/material.dart';
import 'package:flutter_app/data/list_response.dart';

class SimilarMoviesWidget extends StatelessWidget {
  SimilarMoviesWidget(
      {required this.context,
      required this.listResponseSimilarMovies,
      required this.genresOfSimilarMovie});

  final BuildContext context;
  final ListResponse listResponseSimilarMovies;
  final List<String?> genresOfSimilarMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 825),
      height: 275,
      width: 375,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listResponseSimilarMovies.movies?.length,
        itemBuilder: (ctx, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original${listResponseSimilarMovies.movies?[index].posterPath}",
                      // fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    listResponseSimilarMovies.movies?[index].originalTitle ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    genresOfSimilarMovie[index] ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
