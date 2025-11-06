import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
