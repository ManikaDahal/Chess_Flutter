import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Future<void> login({
    required String email, 
    required String password
    }) async {
    await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );
  }


  //LogOut
  Future<void> logout() async{
    await _auth.signOut();
  }
}



