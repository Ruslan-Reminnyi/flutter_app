import 'package:flutter/material.dart';
import 'package:flutter_app/data/credits_response.dart';

class ListCreditsWidget extends StatelessWidget {
  ListCreditsWidget({required this.creditsResponse});

  final CreditsResponse creditsResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 670),
      height: 90,
      width: 375,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: creditsResponse.cast?.length,
        itemBuilder: (ctx, index) {
          if (creditsResponse.cast?[index].path != null) {
            return Container(
              width: 90,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/original${creditsResponse.cast?[index].path}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
