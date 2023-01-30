import 'package:flutter/material.dart'; import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gabriel_logistik/sidemenu.dart';

import '../login.dart';

class Forward extends StatelessWidget {
  const Forward({super.key});

  @override
  Widget build(BuildContext context) {
    Navigator.of(context).push( MaterialPageRoute(builder: (context) => Login()));
        return Container();
  }
}