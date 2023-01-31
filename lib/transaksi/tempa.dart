import 'package:flutter/material.dart'; 

import '../login.dart';

class Forward extends StatelessWidget {
  const Forward({super.key});

  @override
  Widget build(BuildContext context) {
    Navigator.of(context).push( MaterialPageRoute(builder: (context) => const Login()));
        return Container();
  }
}