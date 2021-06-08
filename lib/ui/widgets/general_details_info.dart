import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/ui/widgets/details_info_widget.dart';
import 'package:flutter_app/utils.dart';

const kGeneralDetailsInfoHeight = 140.0;
const kProductionCompanyLogoWidth = 72.0;

class GeneralDetailsInfoWidget extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;
  const GeneralDetailsInfoWidget({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 180.0, 0.0, 0.0), //REVIEW3 paddings of 180 is incorrect to place here
      child: Container(
        height: kGeneralDetailsInfoHeight,
        child: Row(
          children: [
            PosterWidget(movieDetailsResponse: movieDetailsResponse),
            DetailsInfoWidget(
              movieDetailsResponse: movieDetailsResponse,
              creditsResponse: movieDetailsResponse.creditsResponse,
            ),
            ProductionCompanyLogo(movieDetailsResponse: movieDetailsResponse),
          ],
        ),
      ),
    );
  }
}

class PosterWidget extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;
  const PosterWidget({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movieDetailsResponse.posterPath?.isEmpty == false) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Image.network(
          getImagePath(movieDetailsResponse.posterPath),
          fit: BoxFit.fitHeight,
        ),
      );
    } else {
      return Image( //REVIEW3 this image must have the same borders
        height: kImagePlaceholderHeight,
        image: AssetImage('images/image_placeholder.png'),
      );
    }
  }
}

class ProductionCompanyLogo extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;
  const ProductionCompanyLogo({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movieDetailsResponse.productionCompanies?.isEmpty == false) {
      return Container(
        width: kProductionCompanyLogoWidth,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 60.0, 20.0, 0.0),
          child: Image.network(
            getImagePath(
                movieDetailsResponse.productionCompanies?.first.logoPath),
            // fit: BoxFit.fitHeight,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
