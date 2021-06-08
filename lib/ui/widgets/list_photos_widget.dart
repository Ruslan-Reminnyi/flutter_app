import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/list_photo_response.dart';
import 'package:flutter_app/ui/widgets/details_category_name_widget.dart';
import 'package:flutter_app/ui/widgets/photo_item.dart';

class ListPhotosWidget extends StatelessWidget {
  ListPhotosWidget({Key? key, required this.photos}) : super(key: key);

  final ListPhotoResponse? photos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsCategoryNameWidget(
          category: 'Photos',
        ),
        SizedBox(
          height: 6,
        ),
        PhotosList(photos: photos),
      ],
    );
  }
}

class PhotosList extends StatelessWidget {
  final ListPhotoResponse? photos;
  final kListPhotosContainerHeight = 156.0;
  const PhotosList({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (photos?.backdrops?.isEmpty == false) {
      return Container(
        height: kListPhotosContainerHeight,
        width: MediaQuery.of(context).size.width, //REVIEW3 there is no need for width for screen widget should take available space using flex properties
        child: ListView.builder(
          padding: EdgeInsets.only(left: 20, right: 20),
          scrollDirection: Axis.horizontal,
          itemCount: photos?.backdrops?.length,
          itemBuilder: (ctx, index) {
            return PhotoItem(backdropsPath: photos?.backdrops?[index].path);
          },
        ),
      );
    } else {
      return Image(
        height: kImagePlaceholderHeight,
        width: MediaQuery.of(context).size.width,
        image: AssetImage('images/image_placeholder.png'),
      );
    }
  }
}
