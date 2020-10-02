import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine_test/src/ui/screens/auth/login.dart';
import 'package:zartek_machine_test/src/ui/screens/home/home.dart';
import 'package:zartek_machine_test/src/utils/object_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget home = Container(color: Colors.lightGreen);
  initApp(user) {
    if (user == null) {
      setState(() {
        home = Login();
      });
    } else {
      print('User is signed in!');
      setState(() {
        home = UserHome();
      });
    }
  }

  @override
  initState() {
    super.initState();
    ObjectFactory().auth.authStateChanges().listen((User user) {
      initApp(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          textTheme: TextTheme(
              display1: TextStyle(color: Colors.redAccent, fontSize: 17),
              subtitle: TextStyle(color: Colors.black, fontSize: 15),
              body1: TextStyle(color: Colors.grey, fontSize: 15),
              title: TextStyle(color: Colors.black, fontSize: 17)),
          accentColor: Colors.redAccent,
          //primaryColor: Colors.redAccent,
          appBarTheme: AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(color: Colors.grey)),
          scaffoldBackgroundColor: Colors.white),
      home: Scaffold(body: home),
    );
  }
}
