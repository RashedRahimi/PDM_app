import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../screens/forgot_password_page.dart';
import '/widgets/auth/social_button.dart';
import '/widgets/auth/auth_textfiled.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/user_provider.dart';
import '../../screens/auth_page.dart';
import '../../const/social_media.dart';
import '../../utils/context_extension.dart';
import 'sign_up_form.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<LoginForm> {
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          const Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 20),
          Text(
            'Welcome Back! We Miss You',
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
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Forgot password? ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'Reset',
                  style: const TextStyle(color: Colors.purple),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ));
                    },
                ),
              ],
            ),
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
                  text: 'Dont have Account? ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'Signup',
                  style: const TextStyle(color: Colors.purple),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ref.read(selectedCard.notifier).state =
                          const SignUpForm();
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
      await ref.read(userInfoProvider.notifier).signInWithEmail(
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
