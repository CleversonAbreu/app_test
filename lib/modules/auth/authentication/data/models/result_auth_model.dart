// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../domain/entities/result_auth_entity.dart';

class ResultAuthModel extends ResultAuthEntity {
  @override
  // ignore: overridden_fields
  final String token;
  ResultAuthModel({
    required this.token,
  }) : super(token: token);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory ResultAuthModel.fromMap(Map<String, dynamic> map) {
    return ResultAuthModel(
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultAuthModel.fromJson(String source) =>
      ResultAuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
