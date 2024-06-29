import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:validators/validators.dart';
import 'package:flutter/material.dart';

String? validateFullName(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.pleaseInsertYourFullName;
  }
  return null;
}

String? validatePassword(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.pleaseInsertYourPassword;
  } else if (value.length < 6) {
    return AppLocalizations.of(context)!.passwordMustBeGreater;
  } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
    return AppLocalizations.of(context)!
        .passwordShouldContainUppercaseCharacter;
  } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
    return AppLocalizations.of(context)!.passwordMustContainLowercaseLetter;
  } else if (!RegExp(r'^(?=.*[0-9])').hasMatch(value)) {
    return AppLocalizations.of(context)!.passwordMustContainOneNumber;
  } else if (!RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
    return AppLocalizations.of(context)!.passwordMusContainOneSpecialCharacter;
  }
  return null;
}

String? samePasswords(String? value, TextEditingController passwordController,
    BuildContext context) {
  if (value != passwordController.text) {
    return AppLocalizations.of(context)!.passwordsMustBeSame;
  }
  return null;
}

String? validatePhoneNumber(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.pleaseInsertYourPhoneNumber;
  }
  return null;
}

String? validateEmail(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.pleaseInsertYourEmail;
  } else if (!isEmail(value)) {
    return AppLocalizations.of(context)!.pleaseInsertValidEmail;
  }
  return null;
}

String? validateOtp(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.pleaseInsertYourOtp;
  }
  return null;
}
