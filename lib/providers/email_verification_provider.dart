import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdm_app/screens/main_page.dart';
import 'package:pdm_app/screens/paitient_session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_verification_provider.g.dart';

@Riverpod(keepAlive: false)
class EmailVerification extends _$EmailVerification {
  final _auth = FirebaseAuth.instance;
  @override
  bool build() => _auth.currentUser!.emailVerified;

  void updateVerification(bool value) => state = value;

  Future<void> checkVerifyEmail(BuildContext context, Timer? timer) async {
    await _auth.currentUser!.reload();
    state = _auth.currentUser!.emailVerified;
    if (state) {
      timer?.cancel();
      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PatientSesionList()));
      }
    }
  }
}

@Riverpod(keepAlive: false)
class ResendEmailButton extends _$ResendEmailButton {
  @override
  bool build() => false;

  void updateResendEmailButton(bool value) => state = value;
}
