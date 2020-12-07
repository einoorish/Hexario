import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class Trail extends Component{
  Offset playerStartPosition;
  Offset playerEndPosition;
  Color color;

  List<Offset> path;

  Trail(this.playerStartPosition, this.color){
    path = List();
    addPoint(playerStartPosition);
  }

  void addPoint(Offset point){
    path.add(point);
  }

  @override
  void render(Canvas canvas) {
    Paint paint = Paint()
      ..color = this.color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    canvas.drawPoints(PointMode.polygon, path, paint);
    //TODO: use custom painter to draw trail
  }

}
