import 'package:flutter/material.dart';
import 'package:flutter_app/data/list_photo_response.dart';
import 'package:flutter_app/ui/widgets/details_category_name_widget.dart';
import 'package:flutter_app/ui/widgets/photo_item.dart';

class ListPhotosWidget extends StatelessWidget {
  ListPhotosWidget(
      {Key? key, required this.photos, this.padding = EdgeInsets.zero})
      : super(key: key);

  final ListPhotoResponse? photos;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: DetailsCategoryNameWidget(
            category: 'Photos',
          ),
        ),
        SizedBox(
          height: 6,
        ),
        PhotosList(
          photos: photos,
          padding: padding,
        ),
      ],
    );
  }
}

class PhotosList extends StatelessWidget {
  final ListPhotoResponse? photos;
  final kListPhotosContainerHeight = 156.0;
  final EdgeInsets padding;

  const PhotosList(
      {Key? key, required this.photos, this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kListPhotosContainerHeight,
      child: ListView.builder(
        padding: padding,
        scrollDirection: Axis.horizontal,
        itemCount: photos?.backdrops?.length,
        itemBuilder: (ctx, index) {
          return PhotoItem(backdropsPath: photos?.backdrops?[index].path);
        },
      ),
    );
  }
}
