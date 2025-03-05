import 'package:app_test/modules/auth/signup/domain/entities/signup_entity.dart';

class SignUpModel extends SignUpEntity{
  final String email;
  final String? password;
  final String name;

  SignUpModel({required this.email,  this.password, required this.name}) : super(email: email, name: name);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
    );
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      email: map['email'],
      password: map['password'],
      name: map['name'],
    );
  }
  SignUpEntity toEntity() {
    return SignUpEntity(
      email: email,
      name: name,
    );
  }
}