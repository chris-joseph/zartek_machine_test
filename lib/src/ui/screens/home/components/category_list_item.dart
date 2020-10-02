import 'package:flutter/material.dart';
import 'package:zartek_machine_test/src/models/store/store_list_response.dart';

import 'add_remove_item_button.dart';

class CategoryListItem extends StatelessWidget {
  CategoryListItem(this.categoryDish);
  final CategoryDish categoryDish;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 5, 5, 0),
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(categoryDish.dishType == 2
                            ? 'assets/images/veg.png'
                            : 'assets/images/nonveg.png'))),
              ),
            ),
            Flexible(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(categoryDish.dishName,
                          style: Theme.of(context).textTheme.title)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      children: <Widget>[
                        Text('INR  ' + categoryDish.dishPrice.toString(),
                            style: Theme.of(context).textTheme.subtitle),
                        Spacer(),
                        Text(categoryDish.dishCalories.toString() + ' calories',
                            style: Theme.of(context).textTheme.subtitle)
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      categoryDish.dishDescription,
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ),
                  AddRemoveItemButton(
                    categoryDish: categoryDish,
                  ),
                  categoryDish.addonCat.length == 0
                      ? SizedBox()
                      : Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Customizations Available',
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(
                                    fontWeight: FontWeight.w300, fontSize: 16),
                          ),
                        )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 5, 0),
              height: 70,
              width: 60,
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/firebase.png',
                  image: categoryDish.dishImage),
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
