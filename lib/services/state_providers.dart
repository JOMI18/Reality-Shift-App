import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';
import 'package:reality_shift/main.dart';

StateProvider<Map> signUpProvider = StateProvider<Map>((ref) => {});
StateProvider<Map<String, ThemeData>> AppThemeProvider =
    StateProvider<Map<String, ThemeData>>((ref) => {"theme": darkTheme});

StateProvider<UserModel> userProvider = StateProvider<UserModel>((ref) {
  return UserModel(
    id: 0,
    firstname: '',
    surname: '',
    middlename: '',
    email: '',
    image: '',
    country: "",
    number: '',
    status: 0,
    dob: DateTime.now(),
    // isAggregator: 0,
    role: '',
    gender: '',
    deviceModel: '',
    deviceId: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
});
