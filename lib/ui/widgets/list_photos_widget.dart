import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/list_photo_response.dart';
import 'package:flutter_app/utils.dart';

class ListPhotosWidget extends StatelessWidget {
  ListPhotosWidget({Key? key, required this.photos}) : super(key: key);

  final ListPhotoResponse? photos;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 455),
      height: kListPhotosContainerHeight,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photos?.backdrops?.length,
        itemBuilder: (ctx, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 1.4,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  getImagePath(photos?.backdrops?[index].path),
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
