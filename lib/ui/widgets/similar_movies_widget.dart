import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/list_response.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_app/utils.dart';

class SimilarMoviesWidget extends StatelessWidget {
  SimilarMoviesWidget(
      {Key? key,
      required this.context,
      required this.listResponseSimilarMovies,
      required this.genresOfSimilarMovie})
      : super(key: key);

  final BuildContext context;
  final ListResponse? listResponseSimilarMovies;
  final List<String?> genresOfSimilarMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 810),
      height: kSimilarMoviesContainerHeight,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listResponseSimilarMovies?.movies?.length,
        itemBuilder: (ctx, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) {
                      return DetailsScreen(
                        id: listResponseSimilarMovies?.movies?[index].id,
                      );
                    }),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.62,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7.0),
                      child: Image.network(
                        getImagePath(listResponseSimilarMovies
                            ?.movies?[index].posterPath),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: kSimilarMoviesNamesContainerHeight,
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
              Container(
                width: MediaQuery.of(context).size.width / 2.62,
                margin: EdgeInsets.only(top: 3),
                child: Text(
                  genresOfSimilarMovie[index] ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
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
