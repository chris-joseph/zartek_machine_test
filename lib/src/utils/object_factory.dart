import 'package:firebase_auth/firebase_auth.dart';
import 'package:zartek_machine_test/src/resources/repository/repository.dart';
import 'package:zartek_machine_test/src/utils/prefs.dart';

import 'api_client.dart';

class ObjectFactory {
  static final _objectFactory = ObjectFactory._internal();

  ObjectFactory._internal();

  factory ObjectFactory() => _objectFactory;

  //Initialisation of Objects
  FirebaseAuth _auth = FirebaseAuth.instance;
  ApiClient _apiClient = ApiClient();
  Repository _repository = Repository();
  Prefs _prefs = Prefs();

  ///
  /// Getters of Objects
  ///
  ApiClient get apiClient => _apiClient;

  Repository get repository => _repository;

  Prefs get prefs => _prefs;

  FirebaseAuth get auth => _auth;
}
