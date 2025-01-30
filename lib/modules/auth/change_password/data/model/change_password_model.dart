import 'package:app_test/modules/auth/change_password/domain/entities/change_password_entity.dart';

class ChangePasswordModel extends ChangePasswordEntity {
  final String email;
  final String newPassword;

  ChangePasswordModel({required this.email, required this.newPassword}) : super(email: '', newPassword: '');

  factory ChangePasswordModel.fromEntity(ChangePasswordEntity entity) {
    return ChangePasswordModel(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "newPassword": newPassword,
    };
  }
}
