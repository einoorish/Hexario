import 'package:flame/extensions/vector2.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexario/player.dart';
import 'package:hexario/trail.dart';
import 'grid.dart';
import 'dart:ui';
import 'dart:async';

class MyGame extends Game with PanDetector {

  Offset cameraOffset = Offset.zero;

  Size screenSize;
  static int rows = 31, columns = 31;
  static List<List<Color>> gridColorsData = new List.generate(rows, (i) => []); // init somehow??

  MyGrid grid;
  MyPlayer player;
  Trail trail;

  MyGame(){
    initialize();
  }

  Future<void> initialize() async {
    onResize(await Flame.util.initialDimensions());

    for(int i = 0; i < MyGame.rows; i++){
      for(int j = 0; j < MyGame.columns; j++){
        MyGame.gridColorsData[i].add(Colors.white);
      }
    }
    MyGame.gridColorsData[MyGame.rows~/2][MyGame.columns~/2] = Colors.cyan;

    grid = MyGrid(screenSize.width, screenSize.height, MyGame.gridColorsData);
    player = MyPlayer(Offset(screenSize.width/2, screenSize.height/2), grid.computeRadius(screenSize.width, screenSize.height), Colors.cyan, Colors.indigo);
    trail = Trail(player.position, player.circleColor);
  }

  @override
  void render(Canvas canvas) {
    canvas.translate(cameraOffset.dx, cameraOffset.dy);
    grid?.render(canvas);
    trail?.render(canvas);
    player?.render(canvas);
  }

  @override
  void update(double t) {
    grid?.update(t);
    player?.update(t);
    cameraOffset = Offset(-(player.position.dx-screenSize.width/2), -(player.position.dy-screenSize.height/2));
    trail.addPoint(player.position);
  }

  @override
  void onResize(Vector2 size) {
    screenSize = size.toSize();

    grid?.onGameResize(size);
    player?.onGameResize(size);
  }


  @override
  void onPanUpdate(DragUpdateDetails details) {
    player.move(details.globalPosition.dx-screenSize.width/2, details.globalPosition.dy-screenSize.height/2);

    super.onPanUpdate(details);
    //TODO: use onPanStart and onPanEnd data for proper calculations
  }

}
