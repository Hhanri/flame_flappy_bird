import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_flappy_bird/components/background.dart';
import 'package:flame_flappy_bird/components/bird.dart';
import 'package:flame_flappy_bird/components/ground.dart';
import 'package:flame_flappy_bird/components/pipes.dart';

class FlappyBird extends Game with TapDetector {
  late final Background background;
  late List<Ground> groundList;
  List<Pipes> pipes = [];
  late Bird bird;

  late final Timer timer;
  @override
  Future<void> onLoad() async {
    //background initialization

    background = Background(rect: size.toRect());
    //ground initialization
    createGround();

    //pipes initialization
    final Image pipeHead = await images.load("pipe_head.png");
    final Image pipeBody = await images.load("pipe_body.png");
    timer = Timer(
      3,
      repeat: true,
      onTick: () {
        final newPipes = Pipes(screenSize: size.toRect(), pipeBody: pipeBody, pipeHead: pipeHead);
        pipes.add(newPipes);
      }
    );

    //bird initialization
    final Image downFlap = await images.load('downflap.png');
    final Image midFlap = await images.load('midflap.png');
    final Image upFlap = await images.load('upflap.png');
    bird = Bird(screenSize: size.toRect(), downFlap: downFlap, midFlap: midFlap, upFlap: upFlap);
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    pipes.forEach((element) {element.render(canvas);});
    groundList.forEach((element) {element.render(canvas);});
    bird.render(canvas);
  }

  @override
  void update(double dt) {
    timer.update(dt);

    //ground movement
    groundList.forEach((element) {element.update(dt);});
    groundList.removeWhere((element) => element.isVisible == false);
    if (groundList.length < 2) {
      createGround();
    }
    //pipes movement
    pipes.forEach((element) {element.update(dt);});
    pipes.removeWhere((element) => element.isVisible == false);

    bird.update(dt);

    gameOver();
  }

  void createGround() async {
    final Ground ground1 = Ground(leftPos: 0, screenSize: size.toRect());
    final Ground ground2 = Ground(leftPos: size.toRect().width, screenSize: size.toRect());
    groundList = [ground1, ground2];
  }

  void gameOver() {
    pipes.forEach((element) {
      if (element.hasCollision(bird.rect)) {
        print("GAME OVER");
      }
    });
    groundList.forEach((element) {
      if (element.hasCollision(bird.rect)) {
        print("GAME OVER");
      }
    });

    if (bird.rect.top <= 0) {
      print("CEILING");
    }
  }

  @override
  void onTap() {
    super.onTap();
    bird.onTap();
  }
}