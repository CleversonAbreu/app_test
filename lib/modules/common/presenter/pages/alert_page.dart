import 'package:app_test/core/theme/app_collors.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

import '../../../auth/authentication/presenter/pages/auth_page.dart';
import '../../../auth/biometry/data/biometric_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum AlertType { error, warning, success }

class AlertPage extends StatefulWidget {
  final String title;
  final String text;
  final String? titleBtnLeft;
  final String? titleBtnRight;
  final VoidCallback? onPressedBtnLeft;
  final VoidCallback? onPressedBtnRight;
  final BiometricRepository biometricRepository;
  final AlertType? alertType; // Adicionado

  const AlertPage({
    Key? key,
    required this.title,
    required this.text,
    this.titleBtnLeft,
    this.titleBtnRight,
    this.onPressedBtnLeft,
    this.onPressedBtnRight,
    required this.biometricRepository,
    this.alertType, // Adicionado
  }) : super(key: key);

  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  late String _title;
  late String _text;
  AlertType? _alertType;
  Timer? _timer;

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
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AuthPage(),
            ),
          );
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

  IconData _getIconData(AlertType? alertType) {
    switch (alertType) {
      case AlertType.error:
        return Icons.error;
      case AlertType.warning:
        return Icons.warning;
      case AlertType.success:
        return Icons.check_circle;
      default:
        return Icons.info;
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
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_alertType != null)
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.lightBackground,
                    child: Icon(
                      _getIconData(_alertType),
                      color: AppColors.darkBackground,
                      size: 65.sp,
                    ),
                  ),
                SizedBox(height: 16.0),
                Text(
                  _title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  _text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 24.0),
                if (widget.titleBtnLeft != null)
                  ElevatedButton(
                    onPressed: widget.onPressedBtnLeft,
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.darkBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 24.0),
                      child: Text(
                        widget.titleBtnLeft!,
                        style: TextStyle(
                          color: AppColors.lightBackground,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 16.0.h),
                if (widget.titleBtnRight != null)
                  TextButton(
                    onPressed: widget.onPressedBtnRight,
                    child: Text(
                      widget.titleBtnRight!,
                      style: TextStyle(
                        color: AppColors.darkBackground,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.lightGray,
    );
  }
}
