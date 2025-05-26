import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home Screen'**
  String get homeTitle;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomeMessage;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @signInToAccessYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access your account'**
  String get signInToAccessYourAccount;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @newMember.
  ///
  /// In en, this message translates to:
  /// **'New Member?'**
  String get newMember;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @pleaseInsertYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please, insert your email'**
  String get pleaseInsertYourEmail;

  /// No description provided for @pleaseInsertValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please, insert a valid email'**
  String get pleaseInsertValidEmail;

  /// No description provided for @pleaseInsertYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please, insert your password'**
  String get pleaseInsertYourPassword;

  /// No description provided for @pleaseInsertYourOtp.
  ///
  /// In en, this message translates to:
  /// **'Please, insert your OTP'**
  String get pleaseInsertYourOtp;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalidCredentials;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'Error when trying to auth'**
  String get authError;

  /// No description provided for @errorLoadingToken.
  ///
  /// In en, this message translates to:
  /// **'Error loading token'**
  String get errorLoadingToken;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// No description provided for @enterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterYourPhoneNumber;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @enterYourOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter your OTP code'**
  String get enterYourOtp;

  /// No description provided for @pleaseInsertYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Please, insert your full name'**
  String get pleaseInsertYourFullName;

  /// No description provided for @pleaseInsertYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please, insert your phone number'**
  String get pleaseInsertYourPhoneNumber;

  /// No description provided for @byCheckingBoxAgreeTerms.
  ///
  /// In en, this message translates to:
  /// **'By checking the box you agree to our Terms and Conditions.'**
  String get byCheckingBoxAgreeTerms;

  /// No description provided for @alreadyMember.
  ///
  /// In en, this message translates to:
  /// **'Already a member?'**
  String get alreadyMember;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @enterYourRegisteredEmailToRecoverYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email to recover your password'**
  String get enterYourRegisteredEmailToRecoverYourPassword;

  /// No description provided for @youReceivedOtpCodeEmail.
  ///
  /// In en, this message translates to:
  /// **'You received an OTP code in your email'**
  String get youReceivedOtpCodeEmail;

  /// No description provided for @incorrectOTPCode.
  ///
  /// In en, this message translates to:
  /// **'Incorrect OTP code'**
  String get incorrectOTPCode;

  /// No description provided for @enterYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterYourNewPassword;

  /// No description provided for @pleaseInsertYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please, insert your new password'**
  String get pleaseInsertYourNewPassword;

  /// No description provided for @enterYourNewAndConfirmationPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password and confirmation password'**
  String get enterYourNewAndConfirmationPassword;

  /// No description provided for @enterYourConfirmationPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your confirmation password'**
  String get enterYourConfirmationPassword;

  /// No description provided for @pleaseInsertYourConfirmationPassword.
  ///
  /// In en, this message translates to:
  /// **'Please, insert your confirmation password'**
  String get pleaseInsertYourConfirmationPassword;

  /// No description provided for @passwordMustBeGreater.
  ///
  /// In en, this message translates to:
  /// **'Password must be greater than 6 characters'**
  String get passwordMustBeGreater;

  /// No description provided for @passwordShouldContainUppercaseCharacter.
  ///
  /// In en, this message translates to:
  /// **'The password should contain at least 1 uppercase character'**
  String get passwordShouldContainUppercaseCharacter;

  /// No description provided for @passwordMustContainLowercaseLetter.
  ///
  /// In en, this message translates to:
  /// **'The password must contain at least one lowercase letter'**
  String get passwordMustContainLowercaseLetter;

  /// No description provided for @passwordMustContainOneNumber.
  ///
  /// In en, this message translates to:
  /// **'The password must contain at least one number'**
  String get passwordMustContainOneNumber;

  /// No description provided for @passwordMusContainOneSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'The password must contain at least one special character'**
  String get passwordMusContainOneSpecialCharacter;

  /// No description provided for @passwordsMustBeSame.
  ///
  /// In en, this message translates to:
  /// **'Password and password confirmation must be the same'**
  String get passwordsMustBeSame;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createAccount;

  /// No description provided for @insertYourdataToCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Enter your details to create an account'**
  String get insertYourdataToCreateAccount;

  /// No description provided for @enterYourEmailToCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to create an account'**
  String get enterYourEmailToCreateAccount;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @my.
  ///
  /// In en, this message translates to:
  /// **'My '**
  String get my;

  /// No description provided for @opportunity.
  ///
  /// In en, this message translates to:
  /// **'Opportunity'**
  String get opportunity;

  /// No description provided for @completeRegistration.
  ///
  /// In en, this message translates to:
  /// **'Complete Registration'**
  String get completeRegistration;

  /// No description provided for @successfullyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Successfully registered!'**
  String get successfullyRegistered;

  /// No description provided for @doYouWantEnableBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Do you want to enable biometrics?'**
  String get doYouWantEnableBiometrics;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulations;

  /// No description provided for @biometricEnabled.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication has been successfully enabled.'**
  String get biometricEnabled;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @errorBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Error enabling biometrics'**
  String get errorBiometrics;

  /// No description provided for @deviceNotSupportBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Your device does not support the use of biometrics'**
  String get deviceNotSupportBiometrics;

  /// No description provided for @configureBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Configure biometrics'**
  String get configureBiometrics;

  /// No description provided for @youNeedConfigureBiometrics.
  ///
  /// In en, this message translates to:
  /// **'You need to configure your biometrics'**
  String get youNeedConfigureBiometrics;

  /// No description provided for @biometricsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Biometrics enabled'**
  String get biometricsEnabled;

  /// No description provided for @tapSensorFinish.
  ///
  /// In en, this message translates to:
  /// **'Tap the sensor to finish'**
  String get tapSensorFinish;

  /// No description provided for @biometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric Unavailable'**
  String get biometricUnavailable;

  /// No description provided for @biometricNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric not available'**
  String get biometricNotAvailable;

  /// No description provided for @biometry.
  ///
  /// In en, this message translates to:
  /// **'Biometry'**
  String get biometry;

  /// No description provided for @enableBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometrics'**
  String get enableBiometrics;

  /// No description provided for @pleaseAuthenticateContinue.
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to continue'**
  String get pleaseAuthenticateContinue;

  /// No description provided for @yourSafestApp.
  ///
  /// In en, this message translates to:
  /// **'Your safest app'**
  String get yourSafestApp;

  /// No description provided for @useYourPreferredAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Use your preferred authentication'**
  String get useYourPreferredAuthentication;

  /// No description provided for @toContinueUsingApp.
  ///
  /// In en, this message translates to:
  /// **'to continue using the app'**
  String get toContinueUsingApp;

  /// No description provided for @failedToSendOtp.
  ///
  /// In en, this message translates to:
  /// **'Failed to send OTP. Please try again.'**
  String get failedToSendOtp;

  /// No description provided for @failedToGenerateOtp.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate OTP. Please try again.'**
  String get failedToGenerateOtp;

  /// No description provided for @noAccountFoundWithEmail.
  ///
  /// In en, this message translates to:
  /// **'No account found with this email.'**
  String get noAccountFoundWithEmail;

  /// No description provided for @incorrectOtpEntered.
  ///
  /// In en, this message translates to:
  /// **'The OTP entered is incorrect.'**
  String get incorrectOtpEntered;

  /// No description provided for @unknownErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again.'**
  String get unknownErrorOccurred;

  /// No description provided for @requestTimedOut.
  ///
  /// In en, this message translates to:
  /// **'The request timed out. Please try again.'**
  String get requestTimedOut;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully.'**
  String get passwordChangedSuccessfully;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
