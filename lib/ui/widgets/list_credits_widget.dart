import 'package:flutter/material.dart';
import 'package:flutter_app/data/credits_response.dart';
import 'package:flutter_app/utils.dart';

class ListCreditsWidget extends StatelessWidget {
  ListCreditsWidget({required this.creditsResponse});

  final CreditsResponse? creditsResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 670),
      height: MediaQuery.of(context).size.height / 9.5,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: creditsResponse?.cast?.length,
        itemBuilder: (ctx, index) {
          if (creditsResponse?.cast?[index].path != null) {
            return Container(
              width: MediaQuery.of(context).size.width / 4.5,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    getImagePath(creditsResponse?.cast?[index].path),
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
