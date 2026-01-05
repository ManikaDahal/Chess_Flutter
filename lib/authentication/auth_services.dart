import 'dart:math';
import 'package:chess_game/authentication/secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otp/otp.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Signup
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': name,
      'email': email,
      'createdAt': Timestamp.now(),
    });
  }

  //Login
  Future<UserCredential> login({required String email, required String password}) async {
     return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  //LogOut
  Future<void> logout() async {
    await _auth.signOut();
    

  }

  //Generate OTP(email)
  String generateOtp() {
    String otp = OTP.generateHOTPCodeString(
      'FWEWTWYSCSYFA',
      DateTime.now().microsecondsSinceEpoch,
      length: 6,
      algorithm: Algorithm.SHA1,
      isGoogle: false,
    );
    return otp;
  }

  //Save OTP(email)
  Future<void> saveOtp(String email, String otp) async {
    await FirebaseFirestore.instance.collection('emailOtps').doc(email).set({
      'otp': otp,
      'createdAt': Timestamp.now(),
    });
  }

  //Verify OTP(email)
  Future<bool> verifyOtp(String email, String enteredOtp) async {
    var doc = await FirebaseFirestore.instance
        .collection('emailOtps')
        .doc(email)
        .get();
    if (!doc.exists) return false;
    var data = doc.data()!;
    String savedOtp = data['otp'];
    Timestamp createdAt = data['createdAt'];

    if (DateTime.now().difference(createdAt.toDate()).inMinutes > 5) {
      return false;
    }
    return enteredOtp == savedOtp;
  }

  //OTP Send via Phone
  Future<void> sendPhoneOtp(
    String phoneNumber, {
    required Function(String verificationId) codeSent,
    required Function(FirebaseAuthException) verificationFailed,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: verificationFailed,
      codeSent: (verId, resendToken) {
        codeSent(verId);
      },
      codeAutoRetrievalTimeout: (verID) {},
    );
  }

  //Verify OTP(Phone)
  Future<bool> verifyPhoneOtp(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  //Reset Password
  Future<void> resetPassword(String email, String newPassword) async {
    User? user = _auth.currentUser;
    if (user != null && user.email == email) {
      await user.updatePassword(newPassword);
    }
  }



  
}
