import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/utils.dart';

class CreditsItem extends StatelessWidget {
  final String? creditsPath;

  const CreditsItem({Key? key, required this.creditsPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kCreditsItemContainerWidth,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            getImagePath(creditsPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
