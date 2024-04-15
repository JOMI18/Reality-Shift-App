import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class OtpInputs {
  OtpInputs();

  Widget otpField(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode, {
    FocusNode? nextFocusNode,
    FocusNode? prevFocusNode,
    VoidCallback? func,
    bool? isLast,
  }) {
    return SizedBox(
      width: 12.w,
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        focusNode: focusNode,
        maxLength: 1,
        onChanged: (value) {
          if (value.isEmpty && prevFocusNode != null) {
            prevFocusNode.requestFocus();
          }
          if (value != "" && nextFocusNode != null) {
            nextFocusNode.requestFocus();
          }
          if (isLast == true && value != "") {
            func!();
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          fillColor: Colors.white.withOpacity(0.5),
          counter: const SizedBox.shrink(),
        ),
      ),
    );
  }
}
