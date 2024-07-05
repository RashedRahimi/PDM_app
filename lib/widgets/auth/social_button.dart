import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../const/social_media.dart';
class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    super.key,
    this.fontSize = 16,
    required this.onPressed,
    this.child,
    required this.socialMedia,
  });

  final SocialMedia socialMedia;
  final double fontSize;
  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(300, 50),
            backgroundColor: socialMedia.colors(),
            foregroundColor: socialMedia.foregroundColor()),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(socialMedia.icons()))),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Text(
                socialMedia.text(),
              ),
            ),
          ],
        ),
      );
}
