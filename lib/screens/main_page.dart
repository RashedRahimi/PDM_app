import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdm_app/providers/user_provider.dart';
import 'package:pdm_app/screens/patients.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPAgeState();
}

class _MainPAgeState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    final userCridintial = ref.watch(userInfoProvider);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Success'),
            Text(userCridintial!.user!.toString().trim().split('@').first),
            Text(userCridintial.user!.email!),
            Text(userCridintial.user!.uid),
            ElevatedButton(
                onPressed: () {
                  ref.read(userInfoProvider.notifier).logOUt(context);
                },
                child: const Text('logout')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PatientPage()));
                },
                child: const Text('patients'))
          ],
        ),
      ),
    );
  }
}
