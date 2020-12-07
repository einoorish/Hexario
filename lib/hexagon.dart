import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyHexagon extends Component {
  static const int SIDES_OF_HEXAGON = 6;
  final Offset center;
  final double radius;
  Color color;

  MyHexagon(this.center, this.radius, this.color);

  @override
  void render(Canvas canvas) {
    Paint paint = Paint()..color = this.color;

    Path path = createHexagonPath();
    canvas.drawPath(path, paint);

  }

  Path createHexagonPath() {
    final path = Path();
    var angle = (2 * pi) / SIDES_OF_HEXAGON; // 60 degrees
    Offset firstPoint = Offset(radius * cos(0.0), radius * sin(0.0)); // top of the circle

    // start with 0 degrees - top point
    path.moveTo(firstPoint.dx + center.dx, firstPoint.dy + center.dy);

    // rotate each point 60 degrees further from the previous...
    for (int i = 1; i <= SIDES_OF_HEXAGON; i++) {
      double x = radius * cos(angle * i) + center.dx;
      double y = radius * sin(angle * i) + center.dy;
      // Add point to the path
      path.lineTo(x, y);
    }
    path.close();
    return path;
  }

}
