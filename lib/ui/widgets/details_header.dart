import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/ui/widgets/general_details_info.dart';
import 'package:flutter_app/utils.dart';

class DetailsHeader extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;

  DetailsHeader({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Backdrop(movieDetailsResponse: movieDetailsResponse),
        ImageGradient(),
        Column(
          children: [
            GeneralDetailsInfoWidget(
                movieDetailsResponse: movieDetailsResponse),
            SizedBox(
              height: 10,
            ),
            Overview(movieDetailsResponse: movieDetailsResponse),
          ],
        ),
      ],
    );
  }
}

class Backdrop extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;
  Backdrop({Key? key, required this.movieDetailsResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movieDetailsResponse.backdropPath?.isEmpty == false) {
      return Image.network(
        //REVIEW should have all cases of image link construction as function not placed all over the place apply DRY principle
        getImagePath(movieDetailsResponse.backdropPath),
      );
    } else {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 200,
        child: Image(
          height: kImagePlaceholderHeight,
          width: MediaQuery.of(context).size.width,
          image: AssetImage('images/image_placeholder.png'),
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
      child: ShaderMask(
        shaderCallback: (_) => kLinearGradient.createShader(
          Rect.fromLTWH(0, 0, 0, 70),
        ),
        child: Text(
          movieDetailsResponse.overview ?? '',
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
