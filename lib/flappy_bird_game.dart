import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_flappy_bird/components/background.dart';
import 'package:flame_flappy_bird/components/ground.dart';

class FlappyBird extends Game {
  late final Background background;
  late List<Ground> groundList;
  @override
  Future<void> onLoad() async {
    //background initialization
    final bgImage = await images.load("background.png");
    background = Background(rect: size.toRect(), sprite: Sprite(bgImage));
    //ground initialization
    createGround();
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    groundList.forEach((element) {element.render(canvas);});
  }

  @override
  void update(double dt) {
    groundList.forEach((element) {element.update(dt);});
    groundList.removeWhere((element) => element.isVisible == false);
    if (groundList.length < 2) {
      createGround();
    }
  }

  void createGround() async {
    final groundImage = await images.load("base.png");
    final Ground ground1 = Ground(leftPos: 0, screenSize: size.toRect(), sprite: Sprite(groundImage));
    final Ground ground2 = Ground(leftPos: size.toRect().width, screenSize: size.toRect(), sprite: Sprite(groundImage));
    groundList = [ground1, ground2];
  }
}