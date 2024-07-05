import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../providers/email_verification_provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerificationPage extends ConsumerStatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  ConsumerState<EmailVerificationPage> createState() =>
      _EmailVerificationState();
}

class _EmailVerificationState extends ConsumerState<EmailVerificationPage> {
  Timer? timer;
  final _controller = CountdownController(autoStart: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sendVerificationEmail();
      ref.watch(emailVerificationProvider);
    });
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) => ref
          .read(emailVerificationProvider.notifier)
          .checkVerifyEmail(context, timer),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void sendVerificationEmail() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    _controller.restart();
    ref.read(resendEmailButtonProvider.notifier).updateResendEmailButton(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(
              Icons.verified_outlined,
              size: 120,
            ),
            const SizedBox(height: 10),
            Text(
              'we sent a verification email to your email address please check you email',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87.withOpacity(0.5)),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Countdown(
                  controller: _controller,
                  onFinished: () => ref
                      .read(resendEmailButtonProvider.notifier)
                      .updateResendEmailButton(true),
                  seconds: 10,
                  build: (_, time) => Text(
                    'Remaining Time: ${time.toInt()}',
                    style: TextStyle(
                      color: Colors.black87.withOpacity(0.5),
                    ),
                  ),
                  interval: const Duration(seconds: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ref.watch(resendEmailButtonProvider)
                    ? sendVerificationEmail
                    : null,
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
                child: const Text(
                  'Resend verification email',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
