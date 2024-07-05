import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SocialMedia {
  facebook,
  google,
  apple;

  Color colors() => switch (this) {
        facebook => const Color(0xFF3b5998),
        google => Colors.white,
        apple => Colors.black,
      };
  IconData icons() => switch (this) {
        facebook => FontAwesomeIcons.facebook,
        google => FontAwesomeIcons.google,
        apple => FontAwesomeIcons.apple,
      };

  String text() => switch (this) {
        facebook => 'Continue with Facebook',
        google => 'Continue with Google',
        apple => 'Continue with Apple',
      };
  Color foregroundColor() => switch (this) {
        facebook => Colors.white,
        google => Colors.black,
        apple => Colors.white,
      };
}