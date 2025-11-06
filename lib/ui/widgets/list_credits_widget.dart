import 'package:flutter/material.dart';
import 'package:flutter_app/data/credits_response.dart';
import 'package:flutter_app/ui/widgets/credits_item.dart';
import 'package:flutter_app/ui/widgets/details_category_name_widget.dart';

const kCreditsContainerHeight = 80.0;

class ListCreditsWidget extends StatelessWidget {
  ListCreditsWidget({
    super.key,
    this.padding = EdgeInsets.zero,
    required this.creditsResponse,
  });

  final EdgeInsets padding;
  final CreditsResponse? creditsResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: DetailsCategoryNameWidget(category: 'Cast'),
        ),
        SizedBox(height: 6),
        CreditsList(creditsResponse: creditsResponse, padding: padding),
      ],
    );
  }
}

class CreditsList extends StatelessWidget {
  final EdgeInsets padding;
  final CreditsResponse? creditsResponse;

  const CreditsList({
    super.key,
    this.padding = EdgeInsets.zero,
    required this.creditsResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCreditsContainerHeight,
      child: ListView.builder(
        padding: padding,
        scrollDirection: Axis.horizontal,
        itemCount: creditsResponse?.cast?.length,
        itemBuilder: (ctx, index) {
          return CreditsItem(creditsPath: creditsResponse?.cast?[index].path);
        },
      ),
    );
  }
}
