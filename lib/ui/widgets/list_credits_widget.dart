import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/credits_response.dart';
import 'package:flutter_app/ui/widgets/credits_item.dart';
import 'package:flutter_app/ui/widgets/details_category_name_widget.dart';

const kCreditsContainerHeight = 80.0;

class ListCreditsWidget extends StatelessWidget {
  ListCreditsWidget({Key? key, required this.creditsResponse})
      : super(key: key);

  final CreditsResponse? creditsResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsCategoryNameWidget(
          category: 'Cast',
        ),
        SizedBox(
          height: 5, //REVIEW3 always use by default even values
        ),
        CreditsList(creditsResponse: creditsResponse),
      ],
    );
  }
}

class CreditsList extends StatelessWidget {
  final CreditsResponse? creditsResponse;
  const CreditsList({Key? key, required this.creditsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (creditsResponse?.cast?.isEmpty == false) {
      return Container(
        height: kCreditsContainerHeight,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: creditsResponse?.cast?.length,
          itemBuilder: (ctx, index) {
            if (creditsResponse?.cast?[index].path != null) {
              return CreditsItem(
                  creditsPath: creditsResponse?.cast?[index].path);
            } else {
              return SizedBox.shrink(); //REVIEW3 there is no need to hide element, filter or provide placeholdergl
            }
          },
        ),
      );
    } else {
      return Image(//REVIEW3 there is no need to show image placeholder for whole list
        height: kImagePlaceholderHeight,
        width: MediaQuery.of(context).size.width,
        image: AssetImage('images/image_placeholder.png'),
      );
    }
  }
}
