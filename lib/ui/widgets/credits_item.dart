import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/network_image_widget.dart';

const kCreditsItemContainerWidth = 86.0;

class CreditsItem extends StatelessWidget {
  final String? creditsPath;

  const CreditsItem({super.key, required this.creditsPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kCreditsItemContainerWidth,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: NetworkImageWidget(path: creditsPath),
        ),
      ),
    );
  }
}
