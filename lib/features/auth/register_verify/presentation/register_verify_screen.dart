import 'package:aarongonzales01/features/auth/register_verify/widgets/register_verify_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterVerifyScreen extends StatelessWidget {
  const RegisterVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: RegisterVerifyForm(),
      ),
    );
  }
}
