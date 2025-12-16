import 'package:cloud_firestore/cloud_firestore.dart';

class AuthModel {
  final String uid;
  final String email;
  final String fullName;
  final String userName;
  final DateTime dob; //used in home ui
  final int age;
  final String phoneNumber;
  final String address;
  final String gender;

  AuthModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.userName,
    required this.dob,
    required this.age,
    required this.phoneNumber,
    required this.address,
    required this.gender,
  });

  ///from Firestore
  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      userName: map['userName'],
      dob: (map['dob'] as Timestamp).toDate(),
      age: map['age'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      gender: map['gender'],
    );
  }

  ///to Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'dob': Timestamp.fromDate(dob),
      'phoneNumber': phoneNumber,
      'address': address,
      'fullName': fullName,
      'userName': userName,
      'age': age,
      'gender': gender,
    };
  }
}
