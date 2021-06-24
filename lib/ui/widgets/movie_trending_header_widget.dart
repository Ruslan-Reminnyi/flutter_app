import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_model.dart';
import 'package:flutter_app/ui/widgets/heart_widget.dart';
import 'package:flutter_app/ui/widgets/network_image_widget.dart';

class MovieTrendingHeaderWidget extends StatelessWidget {
  MovieTrendingHeaderWidget(
      {Key? key,
      required this.movieModel,
      required this.number,
      required this.sessionId,
      required this.isFavorite})
      : super(key: key);

  final int number;
  final MovieModel? movieModel;
  final String sessionId;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              number < 10 ? '0$number' : '$number',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              movieModel?.originalTitle != null
                  ? '${movieModel?.originalTitle}'
                  : '${movieModel?.originalTitle}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: NetworkImageWidget(
                    path: movieModel?.backdropPath,
                  )),
            ),
          ],
        ),
        sessionId == ''
            ? SizedBox()
            : Heart(
                id: movieModel?.id,
                padding: EdgeInsets.only(top: 50.0),
                isFavorite: isFavorite,
              ),
      ],
    );
  }
}
