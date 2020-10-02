import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine_test/src/ui/screens/auth/login.dart';
import 'package:zartek_machine_test/src/ui/screens/home/home.dart';
import 'package:zartek_machine_test/src/utils/object_factory.dart';
import 'package:zartek_machine_test/src/utils/utils.dart';

class VerifyOTP extends StatefulWidget {
  VerifyOTP(this.verificationId, this.phoneNumber);
  final verificationId;
  final TextEditingController phoneNumber;
  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  TextEditingController otp = TextEditingController();

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
              controller: otp,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "OTP eg: 222222",
                  counter: GestureDetector(
                      onTap: () async {
                        await ObjectFactory().auth.verifyPhoneNumber(
                              phoneNumber: '+' + widget.phoneNumber.text,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UserHome()),
                                    ModalRoute.withName('/'));
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                print(e.message);
                                showToast(e.message);
                              },
                              codeSent:
                                  (String verificationId, int resendToken) {
                                print(verificationId);
                                print(resendToken);
                                showToast(
                                    'OTP sent to ${widget.phoneNumber.text}');
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                      },
                      child: Text('Resend'))),
            ),
          ),
          LoginRoundedButton(
            action: () async {
              // Create a PhoneAuthCredential with the code
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: widget.verificationId, smsCode: otp.text);
              // Sign the user in (or link) with the credential
              try {
                await ObjectFactory()
                    .auth
                    .signInWithCredential(phoneAuthCredential)
                    .then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => UserHome()),
                      ModalRoute.withName('/'));
                });
              } catch (e) {
                showToast(e.toString());
              }
            },
            color: Colors.blue,
            title: "Verify OTP",
          )
        ],
      ),
    );
  }
}
