import 'dart:ffi';

import 'package:dialogs/dialogs/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:second_store/screens/authentication/otp_screen.dart';

class PhoneAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  

  Future<void> verifyPhoneNumber(BuildContext context, number) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth
          .signInWithCredential(credential); //after verification need to signin
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      //if verification faild ,it will show the reson
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
      print('The error is ${e.code}');
    };
    final PhoneCodeSent codeSent = (String verId, int? resendToken) async {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(number: number,verId: verId,),
          ));
    };
    try {
      auth.verifyPhoneNumber(
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: Duration(seconds: 30),
          codeAutoRetrievalTimeout: (String verificationId) {
            print(verificationId);
          });
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
}
