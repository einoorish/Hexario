import 'dart:core';
import 'dart:math';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/position_component.dart';
import 'package:flutter/material.dart';
import 'hexagon.dart';
import 'game.dart';


class MyGrid extends PositionComponent with HasGameRef<MyGame>{

  int rows = MyGame.rows;
  int columns = MyGame.columns;

  static const int margin = 1;
  final double screenWidth;
  final double screenHeight;
  double radius;
  double height;

  List<List<Color>> colors;

  final List<MyHexagon> hexagons = new List();

  MyGrid(this.screenWidth, this.screenHeight, this.colors) {
    radius = computeRadius(screenWidth, screenHeight);
    height = computeHeight(computeRadius(screenWidth, screenHeight));

    for (int x = 0; x < rows; x++) {
      for (int y = 0; y < columns; y++) {
        addChild(gameRef, MyHexagon(computeCenter(x, y), radius, colors[x][y]));
      }
    }

  }

  double computeRadius(double screenWidth, double screenHeight) {
    var maxWidth = (screenWidth - totalMarginX()) / (((rows - 1) * 1.5) + 2);
    var maxHeight = 0.5 *
        (screenHeight - totalMarginY()) /
        (heightRatioOfRadius() * (columns + 0.5));
    return min(maxWidth, maxHeight);
  }

  double heightRatioOfRadius() => cos(pi / MyHexagon.SIDES_OF_HEXAGON);

  double totalMarginY() => (columns - 0.5) * margin;

  int totalMarginX() => (rows - 1) * margin;

  double computeHeight(double radius) => heightRatioOfRadius() * radius * 2;


  Offset computeCenter(int x, int y) => Offset(computeX(x), computeY(x, y));

  computeY(int x, int y) {
    var centerY;
    if (x % 2 == 0) {
      centerY = y * height + y * margin + height / 2;
    } else {
      centerY = y * height + (y + 0.5) * margin + height;
    }
    double marginsVertical = computeEmptySpaceY() / 2;
    return centerY + marginsVertical;
  }

  double computeEmptySpaceY() => screenHeight - ((columns - 1) * height + 1.5 * height + totalMarginY());

  double computeX(int x) =>  x * margin + x * 1.5 * radius + radius + (computeEmptySpaceX() / 2);

  double computeEmptySpaceX() => screenWidth - (totalMarginX() + (rows - 1) * 1.5 * radius + 2 * radius);

}

