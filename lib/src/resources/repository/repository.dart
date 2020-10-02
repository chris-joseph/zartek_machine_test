import 'package:zartek_machine_test/src/models/store/state.dart';
import 'package:zartek_machine_test/src/resources/api_providers/store_api_provider.dart';

class Repository {
  final storeApiProvider = StoreApiProvider();

  ///getStore
  Future<State> getStore() => storeApiProvider.getStore();
}
