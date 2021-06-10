import 'package:flutter/material.dart';
import 'package:flutter_app/data/movie_details_response.dart';
import 'package:flutter_app/ui/widgets/network_image_widget.dart';
import 'package:flutter_app/ui/widgets/details_info_widget.dart';

const kGeneralDetailsInfoHeight = 140.0;
const kProductionCompanyLogoWidth = 72.0;

class GeneralDetailsInfoWidget extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;
  const GeneralDetailsInfoWidget({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class PosterWidget extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;
  const PosterWidget({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: NetworkImageWidget(
        path: movieDetailsResponse.posterPath,
      ),
    );
  }
}

class ProductionCompanyLogo extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;
  const ProductionCompanyLogo({Key? key, required this.movieDetailsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kProductionCompanyLogoWidth,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 60.0, 20.0, 0.0),
        child: NetworkImageWidget(
            path: movieDetailsResponse.productionCompanies?.first.logoPath),
      ),
    );
  }
}
