import 'package:reality_shift/imports.dart';

StateProvider<Map> signUpProvider = StateProvider<Map>((ref) => {});

StateProvider<UserModel> userProvider = StateProvider<UserModel>((ref) {
  return UserModel(
    id: 0,
    firstname: '',
    surname: '',
    middlename: '',
    email: '',
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
