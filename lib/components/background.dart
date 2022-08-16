import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Background {
  final Rect rect;
  final Sprite sprite;

  Background({required this.rect, required this.sprite});

  void update(double t) {

  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }
}