import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class Utils {
  static void showToastWarning(
    String message,
    BuildContext context, {
    double? height,
    double? width,
  }) =>
      MotionToast.warning(
        title: const Text('WARNING'),
        animationDuration: const Duration(seconds: 4),
        description: Text(message.toString()),
        position: MotionToastPosition.top,
        height: height,
        width: width,
      ).show(context);

  static void showToastSuccess(String message, BuildContext context) =>
      MotionToast.success(
        title: const Text('SUCCESS'),
        animationDuration: const Duration(seconds: 4),
        description: Text(message.toString()),
        position: MotionToastPosition.top,
      ).show(context);

  static void showToastError(String message, BuildContext context) =>
      MotionToast.error(
        title: const Text('ERROR'),
        animationDuration: const Duration(seconds: 4),
        description: Text(message.toString()),
        position: MotionToastPosition.top,
      ).show(context);

  static void preCacheImage(ImageProvider provider, BuildContext context) {
    final completer = provider.resolve(ImageConfiguration.empty);

    completer.addListener(ImageStreamListener(
      (imageInfo, sync) async => await precacheImage(provider, context),
    ));
    completer.completer?.keepAlive();
  }
}
