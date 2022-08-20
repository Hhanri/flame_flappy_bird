import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Bird {
  late Rect rect;
  final Rect screenSize;
  final Image downFlap;
  final Image midFlap;
  final Image upFlap;
  late final List<Sprite> spritesList;
  late final Timer timer;
  int spriteIndex = 0;
  double time = 0;

  final double birdHeight = 35;
  final double birdWidth = 50;
  Bird({required this.screenSize, required this.downFlap, required this.midFlap, required this.upFlap}) {

    spritesList = [
      Sprite(downFlap),
      Sprite(midFlap),
      Sprite(upFlap)
    ];

    timer = Timer(
      0.08,
      repeat: true,
      onTick: () {
        spriteIndex = (spriteIndex+1) % 3;
      }
    );
    timer.start();
    rect = Rect.fromLTWH(50, screenSize.height / 2, 50, 35);
  }

  void update(double dt) {
    timer.update(dt);
    rect = rect.translate(0, 9.8*time - 5);
    time += dt;

  }
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(50 + birdWidth/2, rect.bottom/2 - birdHeight/2);
    canvas.rotate((4.9*time-5) * 0.2);
    spritesList[spriteIndex].renderRect(canvas, Rect.fromLTWH(0, 0, 50, 35));
    canvas.restore();

  }

  void onTap() {
    time = 0;
  }
}