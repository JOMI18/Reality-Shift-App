import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  final int id;
  final String firstname;
  final String surname;
  final String? middlename;
  final DateTime dob;
  final String email;
  final String number;
  final String? country;
  final int status;
  // final int isAggregator;
  final String role;
  final String gender;
  final String? image;
  final String deviceModel;
  final String deviceId;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.firstname,
    required this.surname,
    this.middlename,
    required this.dob,
    required this.email,
    required this.number,
    this.country,
    required this.status,
    // required this.isAggregator,
    required this.role,
    required this.gender,
    this.image,
    required this.deviceModel,
    required this.deviceId,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      firstname: json['firstname'] ?? '',
      surname: json['surname'] ?? '',
      middlename: json['middlename'],
      dob: DateTime.parse(json['dob'] ?? ''),
      email: json['email'] ?? '',
      number: json['number'] ?? '',
      country: json['country'],
      status: json['status'] ?? 0,
      // isAggregator: json['isAggregator'] ?? 0,
      role: json['role'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'],
      deviceModel: json['device_model'] ?? '',
      deviceId: json['device_id'] ?? '',
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }
}
