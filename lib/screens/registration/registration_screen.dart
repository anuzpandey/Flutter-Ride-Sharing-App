import 'package:flutter/material.dart';

import 'components/body.dart';

class RegisterScreen extends StatelessWidget {

  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
