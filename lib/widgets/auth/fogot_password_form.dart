import 'package:flutter/material.dart';
import '../auth/auth_textfiled.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/user_provider.dart';
import '../../utils/context_extension.dart';
class ForgotPasswordForm extends ConsumerStatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  ConsumerState<ForgotPasswordForm> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPasswordForm> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      appBar: AppBar(
              title: const Text('Reset Password'),
            ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                'Enter Your Email Address So we Send You a resetPassword Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87.withOpacity(0.5)),
              ),
              const SizedBox(height: 20),
              AuthTextField(
                  hintText: 'Email',
                  validator: (email) => email?.validateEmail(),
                  controller: emailController),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => resetPassword(context),
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
                  child: const Text(
                    'Send email',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      await ref.read(userInfoProvider.notifier).resetPasswordEmail(
          email: emailController.text.trim(), context: context);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
