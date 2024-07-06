import 'package:app_test/core/theme/app_collors.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

import '../../../../../core/constants/app_constants.dart';

import '../../data/biometric_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common/presenter/pages/custom_alert_page.dart';

class BiometryConfigAlertPage extends StatefulWidget {
  final String title;
  final String text;
  final String? titleBtnLeft;
  final String? titleBtnRight;
  final VoidCallback? onPressedBtnLeft;
  final VoidCallback? onPressedBtnRight;
  final BiometricRepository biometricRepository;
  final AlertType alertType;

  const BiometryConfigAlertPage({
    Key? key,
    required this.title,
    required this.text,
    this.titleBtnLeft,
    this.titleBtnRight,
    this.onPressedBtnLeft,
    this.onPressedBtnRight,
    required this.biometricRepository,
    required this.alertType,
  }) : super(key: key);

  @override
  _BiometryConfigAlertPageState createState() =>
      _BiometryConfigAlertPageState();
}

class _BiometryConfigAlertPageState extends State<BiometryConfigAlertPage> {
  double _opacity = 0.0;
  late String _title;
  late String _text;
  AlertType? _alertType;
  Timer? _timer;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _text = widget.text;
    _alertType = widget.alertType;

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
      _startBiometricCheck();
    });
  }

  void _startBiometricCheck() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _checkBiometricSetup();
    });
  }

  void _updateAlert(String title, String text, AlertType alertType) {
    setState(() {
      _title = title;
      _text = text;
      _alertType = alertType;
    });
  }

  Future<void> _checkBiometricSetup() async {
    bool canCheck = await widget.biometricRepository.checkBiometrics();
    if (canCheck) {
      List<BiometricType> availableBiometrics =
          await widget.biometricRepository.getAvailableBiometrics();
      if (availableBiometrics.isNotEmpty) {
        bool authenticated = await widget.biometricRepository.authenticate();
        if (authenticated) {
          String? token = await _secureStorage.read(key: 'token');
          if (token != null) {
            GoRouter.of(context).go('/home');
          } else {
            GoRouter.of(context).go('/auth');
          }
          return;
        } else {
          _updateAlert(AppLocalizations.of(context)!.biometricsEnabled,
              AppLocalizations.of(context)!.tapSensorFinish, AlertType.success);
        }
      } else {
        DeviceApps.openApp('com.android.settings');
        _updateAlert(
            AppLocalizations.of(context)!.configureBiometrics,
            AppLocalizations.of(context)!.youNeedConfigureBiometrics,
            AlertType.warning);
      }
    } else {
      _updateAlert(AppLocalizations.of(context)!.biometricUnavailable,
          AppLocalizations.of(context)!.biometricNotAvailable, AlertType.error);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1),
          child: CustomAlert(
            title: _title,
            text: _text,
            titleBtnLeft: widget.titleBtnLeft,
            titleBtnRight: widget.titleBtnRight,
            onPressedBtnLeft: widget.onPressedBtnLeft,
            onPressedBtnRight: widget.onPressedBtnRight,
            alertType: _alertType,
          ),
        ),
      ),
      backgroundColor: AppColors.lightGray,
    );
  }
}
