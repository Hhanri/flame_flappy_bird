import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Ground {
  late Rect rect;
  final Sprite sprite;
  final double leftPos;
  final Rect screenSize;
  bool isVisible = true;
  final int _groundSpeed = -130;
  Ground({required this.sprite, required this.leftPos, required this.screenSize}) {
    rect = Rect.fromLTWH(leftPos, screenSize.height*7/8, screenSize.width, screenSize.height*1/8);
  }

  void update(double dt) {
    rect = rect.translate(_groundSpeed * dt, 0);

    if (rect.right <= 0) {
      isVisible = false;
    }
  }
  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }
}