import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';

class MovieComingSoonContainer extends StatelessWidget {
  final MovieModel? movieModel;
  final String? genres;

  MovieComingSoonContainer({
    Key? key,
    required this.movieModel,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Details Screen ${movieModel?.genres}"),
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.75,
        margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  "https://image.tmdb.org/t/p/original${movieModel?.poster_path}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieModel?.original_title ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "$genres",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
