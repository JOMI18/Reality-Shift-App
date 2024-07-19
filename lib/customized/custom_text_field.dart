import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class CustomTextField {
  CustomTextField();

  static Widget input(
    context, {
    hint,
    String? fieldname,
    controller,
    bool readOnly = false,
    Icon? prefixIcon,
    bool obscureText = false,
    bool onTapAlwaysCalled = false,
    Icon? suffixIcon,
    Color? color,
    VoidCallback? onSuffixIconTap,
    VoidCallback? onPrefixIconTap,
    VoidCallback? onTap,
    Function(String)? onChanged,
    Function(String)? onFieldSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldname ?? "",
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          onTapAlwaysCalled: onTapAlwaysCalled,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 16.sp,
            letterSpacing: 1.2,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              letterSpacing: 1.2,
              color: color,
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  static Widget dialogBox(
    context, {
    hint,
    String? fieldname,
    controller,
    bool readOnly = false,
    Icon? prefixIcon,
    bool obscureText = false,
    bool onTapAlwaysCalled = false,
    Icon? suffixIcon,
    Color? color,
    VoidCallback? onSuffixIconTap,
    VoidCallback? onPrefixIconTap,
    VoidCallback? onTap,
    Function(String)? onChanged,
    Function(String)? onFieldSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldname ?? "",
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 30.h,
          child: TextField(
            obscureText: obscureText,
            controller: controller,
            onTapAlwaysCalled: onTapAlwaysCalled,
            readOnly: readOnly,
            onTap: onTap,
            onChanged: onChanged,
            style: TextStyle(
              fontSize: 16.sp,
              letterSpacing: 1.2,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                letterSpacing: 1.2,
                color: color,
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
          ),
        ),
      ],
    );
  }
}
