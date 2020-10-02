import 'package:flutter/material.dart';
import 'package:zartek_machine_test/src/ui/screens/auth/phone/phone.dart';
import 'package:zartek_machine_test/src/ui/screens/home/home.dart';
import 'package:zartek_machine_test/src/utils/utils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Image.asset("assets/images/firebase.png"),
          ),
          Flexible(
            flex: 1,
            child: LoginRoundedButton(
              hasImageBackground: true,
              title: "Google",
              action: () async {
                await signInWithGoogle().then((value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => UserHome()),
                    ModalRoute.withName('/'),
                  );
                });
              },
              icon: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage("assets/images/google.png"),
                      ))),
              color: Colors.blue,
            ),
          ),
          Flexible(
            flex: 1,
            child: LoginRoundedButton(
              hasImageBackground: false,
              title: "Phone",
              action: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhoneAuth()));
              },
              icon: Container(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.phone,
                  size: 25,
                ),
              ),
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginRoundedButton extends StatelessWidget {
  LoginRoundedButton(
      {this.title,
      this.icon,
      this.action,
      this.hasImageBackground = false,
      this.color});

  final String title;
  final Widget icon;
  final bool hasImageBackground;
  final action;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: RaisedButton(
        textColor: Colors.white,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            icon != null
                ? icon
                : SizedBox(
                    width: 35,
                  ),
            Expanded(
              child: Container(
                child: Text(
                  title,
                  style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: 35,
            )
          ],
        ),
        onPressed: () {
          action();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70.0),
        ),
      ),
    );
  }
}
