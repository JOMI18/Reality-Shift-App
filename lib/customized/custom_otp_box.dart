import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class OtpInputs {
  OtpInputs();

  Widget otpField(context, _controller, _focusnode) {
    return SizedBox(
      width: 12.w,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: _controller,
        focusNode: _focusnode,
        maxLength: 1,
        // onChanged: (value) {
        //   if (value != "" && nextfocusnode != null) {
        //     nextfocusnode!.requestFocus();
        //   }
        //   if (isLast == true && value != "") {
        //     func!();
        //   }
        // },
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
