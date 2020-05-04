import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (result.user.isEmailVerified)
      return result.user?.uid;
    await signOut();
    return null;
  }

  Future<String> signUp(String email, String password, String _name, String _surname) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // Set name and surname of the users
    final info = UserUpdateInfo();
    info.displayName = '$_name|$_surname';
    result.user.updateProfile(info);

    // Send email verification
    await result.user.sendEmailVerification();
    await signOut();
    return result.user?.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return _firebaseAuth.currentUser();
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
