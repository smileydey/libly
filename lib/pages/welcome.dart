//all pages should have this import
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:html';

import 'package:libly/constants.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: primColor,
      body: Container(
        child: Image.asset(logo),
        alignment: Alignment.center,
      ),
    );
  }
}
