import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CustomPaints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('images/title.png',width: 300,);
  }
}
//Copy this CustomPainter code to the Bottom of the File

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color(0xffffffff).withOpacity(1);
canvas.drawRect(Rect.fromLTWH(size.width*-0.1000000,size.height*-0.1000000,size.width*1.200000,size.height*1.200000),paint_0_fill);

Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
paint_1_fill.color = Color(0xffffffff).withOpacity(1);
canvas.drawRect(Rect.fromLTWH(size.width*-0.1000000,size.height*-0.1000000,size.width*1.200000,size.height*1.200000),paint_1_fill);

Paint paint_2_fill = Paint()..style=PaintingStyle.fill;
paint_2_fill.color = Color(0xffffffff).withOpacity(1);
canvas.drawRect(Rect.fromLTWH(size.width*-0.1000000,size.height*-0.1000000,size.width*1.200000,size.height*1.200000),paint_2_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}