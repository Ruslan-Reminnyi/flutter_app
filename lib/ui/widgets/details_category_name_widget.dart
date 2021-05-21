import 'package:flutter/material.dart';

class DetailsCategoryNameWidget extends StatelessWidget {
  DetailsCategoryNameWidget({this.category, required this.marginTop});

  final String? category;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: marginTop),
      child: Text(
        '$category',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
