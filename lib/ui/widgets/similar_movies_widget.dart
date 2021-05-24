import 'package:flutter/material.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/utils.dart';

class SimilarMoviesWidget extends StatelessWidget {
  SimilarMoviesWidget(
      {required this.context,
      required this.listResponseSimilarMovies,
      required this.genresOfSimilarMovie});

  final BuildContext context;
  final ListResponse? listResponseSimilarMovies;
  final List<String?> genresOfSimilarMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 815),
      height: MediaQuery.of(context).size.height / 2.75,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listResponseSimilarMovies?.movies?.length,
        itemBuilder: (ctx, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.62,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: Image.network(
                      getImagePath(listResponseSimilarMovies?.movies?[index].posterPath),
                      // fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.62,
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    listResponseSimilarMovies?.movies?[index].originalTitle ?? '',
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
                  width: MediaQuery.of(context).size.width / 2.62,
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
