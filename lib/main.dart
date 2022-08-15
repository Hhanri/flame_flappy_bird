import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_flappy_bird/flappy_bird_game.dart';
import 'package:flutter/material.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();
  FlappyBird game = FlappyBird();
  runApp(GameWidget(game: game));
}