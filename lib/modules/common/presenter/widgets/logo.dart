import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  final String path;
  const Logo({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        path,
        height: 200.h,
      ),
    );
  }
}
