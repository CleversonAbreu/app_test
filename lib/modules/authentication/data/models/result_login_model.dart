// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_test/modules/authentication/domain/entities/result_login_entity.dart';

class ResultLoginModel extends ResultLoginEntity {
  final String token;
  ResultLoginModel({
    required this.token,
  }) : super(token: token);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory ResultLoginModel.fromMap(Map<String, dynamic> map) {
    return ResultLoginModel(
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultLoginModel.fromJson(String source) =>
      ResultLoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
