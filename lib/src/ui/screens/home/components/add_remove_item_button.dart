import 'package:flutter/material.dart';
import 'package:zartek_machine_test/src/blocs/store_bloc.dart';
import 'package:zartek_machine_test/src/models/store/store_list_response.dart';

class AddRemoveItemButton extends StatelessWidget {
  AddRemoveItemButton(
      {this.color = Colors.green, this.categoryDish, this.width = 140});
  final CategoryDish categoryDish;
  final Color color;
  final double width;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: storeBloc.cartCountSubject.stream,
        builder: (context, snapshot) {
          return Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(vertical: 8),
            width: width,
            height: 40,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(50), right: Radius.circular(50)),
                shape: BoxShape.rectangle),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    storeBloc.removeItem(categoryDish);
                  },
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
                Text(
                  storeBloc.cart.containsKey(num.parse(categoryDish.dishId))
                      ? storeBloc.cart[num.parse(categoryDish.dishId)].count
                          .toString()
                      : '0',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                IconButton(
                  onPressed: () {
                    storeBloc.addItem(categoryDish);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          );
        });
  }
}
