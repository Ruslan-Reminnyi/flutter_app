import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/ui/widgets/general_details_info.dart';
import 'package:flutter_app/utils.dart';

const LinearGradient kLinearGradient = LinearGradient(
  colors: <Color>[Colors.white, Colors.black],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const kBackdropGradientHeight = 200.0;
const kOverviewWidth = 370.0;

class DetailsHeader extends StatelessWidget {
  final int id;
  final MovieDetailsResponse movieDetailsResponse;

  DetailsHeader(
      {Key? key, required this.id, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      //REVIEW3 too much elements in stack or move padding to this widget
      children: [
        Backdrop(id: id, movieDetailsResponse: movieDetailsResponse),
        // ImageGradient(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 180.0, 0.0, 0.0),
          child: Column(
            children: [
              GeneralDetailsInfoWidget(
                  movieDetailsResponse: movieDetailsResponse),
              SizedBox(
                height: 10,
              ),
              Overview(movieDetailsResponse: movieDetailsResponse),
            ],
          ),
        ),
      ],
    );
  }
}

class Backdrop extends StatelessWidget {
  final int id;
  final MovieDetailsResponse movieDetailsResponse;

  Backdrop({Key? key, required this.id, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movieDetailsResponse.backdropPath?.isEmpty == false) {
      return Stack(children: [
        Image.network(
          //REVIEW should have all cases of image link construction as function not placed all over the place apply DRY principle
          getImagePath(movieDetailsResponse.backdropPath),
        ),
        ImageGradient(),
      ]);
    } else {
      return Center(
        heightFactor: 12,
        child: Text(
          'no backdrop',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }
}

class ImageGradient extends StatelessWidget {
  ImageGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBackdropGradientHeight,
      //REVIEW magic numbers
      //REVIEW magic numbers
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.black,
          ],
          stops: [0.0, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class Overview extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;
  const Overview({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kOverviewWidth,
      height: 80,
      child: ShaderMask(
        shaderCallback: (_) => kLinearGradient.createShader(
          Rect.fromLTWH(0, 0, 0, 70),
        ),
        child: Text(
          //REVIEW3 view is too big
          movieDetailsResponse.overview ?? '',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
