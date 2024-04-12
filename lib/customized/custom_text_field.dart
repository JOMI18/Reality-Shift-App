import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class CustomTextField {
  CustomTextField();

 static Widget input(
    context, {
    hint,
    fieldname,
    controller,
    bool readOnly = false,
    Icon? prefixIcon,
    bool obscureText = false,
    Icon? suffixIcon,
    VoidCallback? onSuffixIconTap,
    VoidCallback? onPrefixIconTap,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldname,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          style: TextStyle(
              fontSize: 16.sp, letterSpacing: 1.2, color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              letterSpacing: 1.2,
            ),
            filled: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onSuffixIconTap,
                    child: suffixIcon,
                  )
                : null,
            contentPadding: const EdgeInsets.all(15),
            fillColor: Colors.white.withOpacity(0.5),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
