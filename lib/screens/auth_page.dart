
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/auth/log_in_form.dart';

final selectedCard = StateProvider<Widget>((ref) => const LoginForm());

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<AuthPage> {
  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        body: Row(
      children: [
        Expanded(
            child: Container(
          padding: null,
          child: ref.watch(selectedCard),
        )),
      
      ],
    ));
  }
}
