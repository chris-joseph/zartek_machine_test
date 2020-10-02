import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine_test/src/blocs/store_bloc.dart';
import 'package:zartek_machine_test/src/utils/utils.dart';

import 'components/cart_item.dart';

class CheckOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            'Order Summary',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body1.copyWith(fontSize: 20),
          )),
      body: StreamBuilder<int>(
          stream: storeBloc.cartCountSubject.stream,
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(5),
                    shadowColor: Colors.grey,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(5),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 77, 0, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                '${storeBloc.cart.keys.length} Dishes - ${storeBloc.cartCountSubject.stream.value} items',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(color: Colors.white),
                              ),
                            )),
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: ListView.builder(
                              itemCount: storeBloc.cart.values.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SingleCartItem(
                                    cartItem:
                                        storeBloc.cart.values.toList()[index]);
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 20),
                          //alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Text('Total Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                              Spacer(),
                              Text('INR ' + storeBloc.getTotal().toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(color: Colors.green))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromRGBO(0, 77, 0, 1),
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 55,
                    onPressed: () {
                      showToast('Order Placed');
                      storeBloc.clearCart();
                      Navigator.pop(context);
                    },
                    color: Color.fromRGBO(0, 77, 0, 1),
                    child: Text(
                      'Place Order',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
