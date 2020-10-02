import 'package:zartek_machine_test/src/models/store/state.dart';
import 'package:zartek_machine_test/src/models/store/store_list_response.dart';
import 'package:zartek_machine_test/src/utils/object_factory.dart';

class StoreApiProvider {
  Future<State> getStore() async {
    final response = await ObjectFactory().apiClient.storeApi();
    //print(response);
    if (response.statusCode == 200) {
      return State<StoreListResponse>.success(
          StoreListResponse.fromJson(response.data[0]));
    } else {
      return null;
    }
  }
}
