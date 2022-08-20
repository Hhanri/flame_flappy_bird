import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class GameOver {
  late final Rect rect;
  late final Sprite sprite;
  final Rect screenSize;
  GameOver({required this.screenSize, required Image image}) {
    sprite = Sprite(image);
    rect = Rect.fromCenter(center: screenSize.center, width: screenSize.width / 2, height: screenSize.height / 2);
  }

  void update(double dt) {

  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }
}