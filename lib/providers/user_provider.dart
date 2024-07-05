import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdm_app/screens/main_page.dart';
import 'package:pdm_app/screens/paitient_session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/repository/auth_repo.dart';

import '/screens/auth_page.dart';
import '/screens/email_verification_page.dart';
import '/utils/utils.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserInfo extends _$UserInfo {
  final auth = FirebaseAuth.instance;
  final _authRepo = const AuthRepository();
  @override
  UserCredential? build() => null;

  Future<void> googleAuth({
    required BuildContext context,
  }) async {
    try {
      if (kIsWeb) {
        state = await _authRepo.googleAuthWeb();
      } else {
        state = await _authRepo.googleAuthMobile();
      }

      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PatientSesionList()));
      }
    } on FirebaseAuthException catch (error) {
      debugPrint('Auth Error: ${error.code} ==>> ${error.message}');
      if (context.mounted) {
        Utils.showToastError(firebaseAuthErrorMessage(error), context);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final userCredential = await _authRepo.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = userCredential;
      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const VerificationPage()));
      }
    } on FirebaseAuthException catch (error) {
      debugPrint('Auth Error: ${error.code} ==>> ${error.message}');
      if (context.mounted) {
        Utils.showToastError(firebaseAuthErrorMessage(error), context);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUpWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final userCredential = await _authRepo.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = userCredential;
      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const VerificationPage()));
      }
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        Utils.showToastError(firebaseAuthErrorMessage(error), context);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPasswordEmail({
    required String email,
    required BuildContext context,
  }) async {
    try {
      _authRepo.resetPassword(email: email);
      if (context.mounted) {
        Utils.showToastSuccess('Check Your Email', context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ));
      }
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        Utils.showToastError(firebaseAuthErrorMessage(error), context);
      }
    } catch (e) {
      Utils.showToastError(e.toString(), context);
      rethrow;
    }
  }

  Future<void> logOUt(BuildContext context) async {
    try {
      await auth.signOut();
      state = null;
      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ));
      }
    } catch (e) {
      if (context.mounted) {
        Utils.showToastError(e.toString(), context);
      }
      rethrow;
    }
  }

  String firebaseAuthErrorMessage(FirebaseAuthException e) => switch (e.code) {
        'weak-password' => 'The password provided is too weak.',
        'email-already-in-use' => 'The account already exists for that email.',
        'user-not-found' => 'No user found for that email.',
        'wrong-password' => 'Wrong password provided for that user.',
        'invalid-credential' => 'Invalid auth credential',
        'invalid-email' => 'Invalid Email',
        _ => e.message!.split('Firebase:').last.split('.').first.toString(),
      };
}
