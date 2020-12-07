import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class MyPlayer extends Component{

  int SPEED = 1;
  Offset position, direction = Offset(0, 0);
  final double radius;
  Color circleColor, borderColor;

  MyPlayer(this.position, this.radius, this.circleColor, this.borderColor);

  @override
  void render(Canvas canvas) {
    Paint paintCircle = Paint()..color = circleColor;
    Paint paintBorder = Paint()
      ..color = borderColor
      ..strokeWidth = radius/3
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(position, radius, paintCircle);
    canvas.drawCircle(position, radius, paintBorder);
  }


  @override
  void update(double dt) {
    position = position.translate((direction.dx/5 * SPEED) * dt, (direction.dy/5 * SPEED) * dt);
  }

  void move(double x, double y){
    print("x: $x, y: $y");
    direction = Offset(x, y);
  }


}