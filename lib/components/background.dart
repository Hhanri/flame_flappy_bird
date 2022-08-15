import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Background {
  final Rect bgRect;
  final Sprite bgSprite;

  Background({required this.bgRect, required this.bgSprite});

  void update(double t) {

  }

  void render(Canvas canvas) {
    bgSprite.render(canvas, size: bgRect.size.toVector2());
  }
}