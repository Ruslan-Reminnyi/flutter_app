import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/screens/details_page_screen.dart';
import 'package:flutter_app/utils.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Details Screen ${movieModel?.genres}"),
        ));

        Navigator.push(
          context,
          MaterialPageRoute(
              //REVIEW has a lot fo data passed in that it shouldn't have
              builder: (ctx) {
            return DetailsScreen(
              id: movieModel?.id,
            );
          }),
        );
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
                  getImagePath(movieModel?.posterPath),
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
                    movieModel?.originalTitle ?? '',
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
