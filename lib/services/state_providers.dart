import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

StateProvider<Map> signUpProvider = StateProvider<Map>((ref) => {});
StateProvider<List<Map<String, dynamic>>> BucketListProvider =
    StateProvider<List<Map<String, dynamic>>>((ref) => []);
StateProvider<NoteData> NotesProvider =
    StateProvider<NoteData>((ref) => NoteData());
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
