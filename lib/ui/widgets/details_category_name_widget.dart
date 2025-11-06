import 'package:flutter/material.dart';

class DetailsCategoryNameWidget extends StatelessWidget {
  DetailsCategoryNameWidget({super.key, this.category});

  final String? category;

  @override
  Widget build(BuildContext context) {
    return Text(
      category ?? '',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        decoration: TextDecoration.none,
      ),
    );
  }
}
