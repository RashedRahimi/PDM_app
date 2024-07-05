import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';


class AuthTextField extends StatefulWidget {
  final String hintText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final bool obscureText;

  const AuthTextField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.obscureText = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(widget.hintText),
        ),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: widget.obscureText && !isVisible,
          controller: widget.controller,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () => setState(() => isVisible = !isVisible),
                    icon: isVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.white),
            contentPadding: const EdgeInsets.only(
              left: 16,
            ),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.borderColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
        ),
      ],
    );
  }
}
