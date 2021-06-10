import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/network_image_widget.dart';

const kPhotoItemWidth = 280.0;

class PhotoItem extends StatelessWidget {
  final String? backdropsPath;

  const PhotoItem({Key? key, this.backdropsPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kPhotoItemWidth,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: NetworkImageWidget(
            path: backdropsPath,
          ),
        ),
      ),
    );
  }
}
