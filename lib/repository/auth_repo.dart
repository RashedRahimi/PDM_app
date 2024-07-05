import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
 final  auth = FirebaseAuth.instance;
 
class AuthRepository {
  const AuthRepository();
 
  Future<UserCredential?> facebookAuthMobile() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> facebookAuthWeb() async {
    final facebookprovider = FacebookAuthProvider();
    try {
      return await auth.signInWithPopup(facebookprovider);
    } catch (error) {
      rethrow;
    }
  } 
 

  Future<UserCredential?> googleAuthMobile() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final credential = await auth.signInWithCredential(authCredential);
      return credential;
    } catch (error) {
      rethrow;
    }
  }

  Future<UserCredential?> googleAuthWeb() async {
    final googleprovider = GoogleAuthProvider();
    try {
      return await auth.signInWithPopup(googleprovider);
    } catch (error) {
      rethrow;
    }
  }


  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
  
}
