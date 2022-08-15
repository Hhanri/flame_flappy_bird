import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_flappy_bird/components/background.dart';

class FlappyBird extends Game {
  Background? background;

  @override
  Future<void> onLoad() async {
    final image = await images.load("background.png");
    background = Background(bgRect: size.toRect(), bgSprite: Sprite(image));
  }

  @override
  void render(Canvas canvas) {
    if (background != null) {
      background?.render(canvas);
    }
    print(size);
  }

  @override
  void update(double dt) {
    // TODO: implement update
  }
}