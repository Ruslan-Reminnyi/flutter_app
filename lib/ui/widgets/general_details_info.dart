import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/ui/widgets/details_info_widget.dart';
import 'package:flutter_app/utils.dart';

class GeneralDetailsInfoWidget extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;
  const GeneralDetailsInfoWidget({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 180.0, 0.0, 0.0),
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
        borderRadius: BorderRadius.circular(5.0),
        child: Image.network(
          getImagePath(movieDetailsResponse.posterPath),
          fit: BoxFit.fitHeight,
        ),
      );
    } else {
      return Image(
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
