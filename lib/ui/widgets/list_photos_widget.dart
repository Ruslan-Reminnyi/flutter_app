import 'package:flutter/material.dart';
import 'package:flutter_app/data/list_photo_response.dart';

class ListPhotosWidget extends StatelessWidget {
  ListPhotosWidget({required this.photos});

  final ListPhotoResponse? photos;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 450),
      height: 155,
      width: 375,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photos?.backdrops?.length,
        itemBuilder: (ctx, index) {
          return Container(
            width: 280,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  "https://image.tmdb.org/t/p/original${photos?.backdrops?[index].path}",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
