import 'package:zartek_machine_test/src/models/store/store_list_response.dart';

class CartItem {
  CartItem({
    this.id,
    this.categoryDish,
    this.count,
  });

  CategoryDish categoryDish;
  int count;
  int id;
  get total => categoryDish.dishPrice * count;
}
