import 'package:flutter/material.dart';
import 'package:flutter_app/utils.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? path;

  const NetworkImageWidget({super.key, this.path});

  @override
  Widget build(BuildContext context) {
    return path != null && path?.isNotEmpty == true
        ? Image.network(getImagePath(path), fit: BoxFit.cover)
        : Image(image: AssetImage('images/image_placeholder.png'));
  }
}
