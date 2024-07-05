import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/auth_page.dart';
import '../../providers/user_provider.dart';
import '../../utils/context_extension.dart';
import 'auth_textfiled.dart';
import 'log_in_form.dart';
import 'social_button.dart';
import '../../const/social_media.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpForm> {
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          const Text(
            'SignUp',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 20),
          Text(
            'Welcome to our platform! Create your account to unlock a world of possibilities',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87.withOpacity(0.5)),
          ),
          const SizedBox(height: 40),
          AuthTextField(
              hintText: 'Email',
              validator: (email) => email.validateEmail(),
              controller: emailController),
          const SizedBox(height: 20),
          AuthTextField(
            hintText: 'Password',
            validator: (password) => password.validateEmptyText('Password'),
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          AuthTextField(
            hintText: 'Re-Enter Password',
            validator: (password) => password.validateEmptyText('Password'),
            controller: rePass,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
              onPressed: () => signUp(context),
              child: const Text('SignUp')),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'have Account? ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'Login',
                  style: const TextStyle(color: Colors.purple),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ref.read(selectedCard.notifier).state = const LoginForm();
                    },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          SocialButtonWidget(
              onPressed: () {
                ref
                    .read(userInfoProvider.notifier)
                    .googleAuth(context: context);
              },
              socialMedia: SocialMedia.google),
        ],
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    try {
      setState(() => isLoading = true);
      await ref.read(userInfoProvider.notifier).signUpWithEmail(
          context: context,
          email: emailController.text.trim(),
          password: passwordController.text);
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      rethrow;
    }
  }
}
