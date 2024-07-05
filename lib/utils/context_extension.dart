import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:email_validator/email_validator.dart';
extension ContextExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;
  // bool get isDesktop => screenWidth > 1100;
  bool get isDesktop => ResponsiveBreakpoints.of(this).isDesktop;
  bool get isMobile => ResponsiveBreakpoints.of(this).isMobile;
  bool get isTablet => ResponsiveBreakpoints.of(this).isTablet;
}



extension StringExtension on String? {
  String? validateEmail() {
    if (this == null || this?.isEmpty == true) {
      return 'Email is required!';
    } else if (!EmailValidator.validate(this!)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  String? validateEmptyText(String fieldName) =>
      this == null || this?.isEmpty == true ? '$fieldName is required!' : null;
}
