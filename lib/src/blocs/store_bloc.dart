import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:zartek_machine_test/src/models/store/cart.dart';
import 'package:zartek_machine_test/src/models/store/state.dart';
import 'package:zartek_machine_test/src/models/store/store_list_response.dart';
import 'package:zartek_machine_test/src/utils/object_factory.dart';

import 'base_bloc.dart';

class StoreBloc extends BaseBloc {
  Map<int, CartItem> cart = {};

  StreamController<StoreListResponse> _storeList =
      StreamController<StoreListResponse>.broadcast();
  StreamSink<StoreListResponse> get storeListSink => _storeList.sink;
  Stream<StoreListResponse> get storeListResponse => _storeList.stream;

  ReplaySubject<CartItem> cartSubject = new ReplaySubject<CartItem>();

  BehaviorSubject<int> cartCountSubject = new BehaviorSubject<int>.seeded(0);

  getStore() async {
    State state = await ObjectFactory().repository.getStore();

    if (state is SuccessState) {
      _storeList.sink.add(state.value);
    } else if (state is ErrorState) {
      _storeList.sink.addError("error");
    }
  }

  double getTotal() {
    double amount = 0;
    cart.values.forEach((CartItem item) {
      amount = amount + item.total;
    });
    return amount;
  }

  addItem(CategoryDish categoryDish) {
    cart[num.parse(categoryDish.dishId)] = CartItem(
        categoryDish: categoryDish,
        count: cart.containsKey(num.parse(categoryDish.dishId))
            ? (cart[num.parse(categoryDish.dishId)].count + 1)
            : 1);
    cartCountSubject.add(cartCountSubject.stream.value + 1);
    cart.values.forEach((e) {
      print(e.count);
      print(e.categoryDish.dishName);
    });
  }

  removeItem(CategoryDish categoryDish) {
    if (cart.containsKey(num.parse(categoryDish.dishId))) {
      if (cart[num.parse(categoryDish.dishId)].count >= 1) {
        cart[num.parse(categoryDish.dishId)] = CartItem(
            categoryDish: categoryDish,
            count: (cart[num.parse(categoryDish.dishId)].count - 1));
      }
      if (cart[num.parse(categoryDish.dishId)].count == 0) {
        cart.remove(num.parse(categoryDish.dishId));
      }
      if (cartCountSubject.stream.value > 0) {
        cartCountSubject.add(cartCountSubject.stream.value - 1);
      }
      print(cart.keys.toList());
      cart.values.forEach((e) {
        print(e.count);
        print(e.categoryDish.dishName);
      });
    }
  }

  clearCart() {
    cart.clear();
    cartCountSubject.add(0);
  }

  @override
  void dispose() {
    cartCountSubject?.close();
    cartSubject?.close();
    _storeList?.close();
  }
}

final storeBloc = StoreBloc();
