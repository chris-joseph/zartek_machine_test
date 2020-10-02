import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine_test/src/ui/screens/auth/login.dart';
import 'package:zartek_machine_test/src/ui/screens/auth/phone/verify_otp.dart';
import 'package:zartek_machine_test/src/ui/screens/home/home.dart';
import 'package:zartek_machine_test/src/utils/object_factory.dart';
import 'package:zartek_machine_test/src/utils/utils.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: TextField(
              autofocus: true,
              controller: phoneNumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Mobile with country code eg :91 1111111111"),
            ),
          ),
          LoginRoundedButton(
            color: Colors.blue,
            title: "Send OTP",
            action: () async {
              await ObjectFactory().auth.verifyPhoneNumber(
                    phoneNumber: '+' + phoneNumber.text,
                    verificationCompleted: (PhoneAuthCredential credential) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => UserHome()),
                          ModalRoute.withName('/'));
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      print(e.message);
                      showToast(e.message);
                    },
                    codeSent: (String verificationId, int resendToken) {
                      print(verificationId);
                      print(resendToken);
                      showToast('OTP sent to ${phoneNumber.text}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VerifyOTP(verificationId, phoneNumber)));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
            },
          )
        ],
      ),
    );
  }
}
