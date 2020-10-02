import 'package:flutter/material.dart';
import 'package:zartek_machine_test/src/models/store/cart.dart';
import 'package:zartek_machine_test/src/ui/screens/home/components/add_remove_item_button.dart';

class SingleCartItem extends StatelessWidget {
  SingleCartItem({this.cartItem});
  final CartItem cartItem;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(cartItem.categoryDish.dishType == 2
                              ? 'assets/images/veg.png'
                              : 'assets/images/nonveg.png'))),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
                        alignment: Alignment.centerLeft,
                        child: Text(cartItem.categoryDish.dishName,
                            style: Theme.of(context).textTheme.title)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                          'INR  ' + cartItem.categoryDish.dishPrice.toString(),
                          style: Theme.of(context).textTheme.subtitle),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            cartItem.categoryDish.dishCalories.toString() +
                                ' calories',
                            style: Theme.of(context).textTheme.subtitle)),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AddRemoveItemButton(
                      color: Color.fromRGBO(0, 77, 0, 1),
                      width: 110,
                      categoryDish: cartItem.categoryDish,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 8, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Text('INR ${cartItem.total}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            Divider(),
          ],
        ));
  }
}
