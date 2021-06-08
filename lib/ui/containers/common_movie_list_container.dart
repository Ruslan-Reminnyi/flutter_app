import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_app/utils.dart';

class CommonMovieListWidget extends StatelessWidget {
  final MovieModel? movieModel;
  final String? genres;

  CommonMovieListWidget({
    Key? key,
    required this.movieModel,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) {
            return DetailsScreen(
              id: movieModel?.id ?? 1, //REVIEW3 default 1 is incorrect
            );
          }),
        );
      },
      child: Container(
        width: kCommonMovieListContainerHeight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    getImagePath(movieModel?.posterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: kMovieComingSoonTextContainerHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      movieModel?.originalTitle ?? '',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      genres ?? '',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
