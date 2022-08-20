import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Background {
  final Rect rect;
  late final Sprite sprite;

  Background({required this.rect}) {
   Sprite.load("background.png").then((value) => sprite = value);
  }

  void update(double t) {}

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }
}