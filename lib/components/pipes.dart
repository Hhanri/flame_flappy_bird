import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';

class Pipes {
  final Image pipeBody;
  final Image pipeHead;

  late Rect topBodyPipeRect;
  late Rect topHeadPipeRect;
  late final Sprite topBodyPipeSprite;
  late final Sprite topHeadPipeSprite;

  late Rect bottomBodyPipeRect;
  late Rect bottomHeadPipeRect;
  late final Sprite bottomBodyPipeSprite;
  late final Sprite bottomHeadPipeSprite;
  final Rect screenSize;

  final double _pipeWidth = 70;
  final double _headPipeHeight = 20;
  final double _pipesGap = 150;
  final double _pipeSpeed = -130;

  bool isVisible = true;

  late final List<double> _pipeHeights;

  Pipes({required this.screenSize, required this.pipeBody, required this.pipeHead}) {
    topBodyPipeSprite = Sprite(pipeBody);
    topHeadPipeSprite = Sprite(pipeHead);
    bottomBodyPipeSprite = Sprite(pipeBody);
    bottomHeadPipeSprite = Sprite(pipeHead);

    _pipeHeights = [
      screenSize.height / 12,
      screenSize.height / 11,
      screenSize.height / 10,
      screenSize.height / 9,
      screenSize.height / 8,
      screenSize.height / 7,
      screenSize.height / 6,
      screenSize.height / 5,
      screenSize.height / 4,
      screenSize.height / 3,
      screenSize.height / 2,
    ];

    final double topPipeHeight = _pipeHeights[Random.secure().nextInt(_pipeHeights.length)];

    topBodyPipeRect = Rect.fromLTWH(screenSize.width + 10, 0, _pipeWidth, topPipeHeight);
    topHeadPipeRect = Rect.fromLTWH(screenSize.width + 10, topPipeHeight, _pipeWidth+ 2, _headPipeHeight);


    final bottomPipeTop = topPipeHeight + _headPipeHeight*2 + _pipesGap;
    bottomBodyPipeRect = Rect.fromLTWH(
      screenSize.width + 10,
      bottomPipeTop,
      _pipeWidth ,
      screenSize.height - bottomPipeTop
    );
    bottomHeadPipeRect = Rect.fromLTWH(
      screenSize.width + 10,
      topPipeHeight + _headPipeHeight + _pipesGap,
      _pipeWidth+2,
      _headPipeHeight
    );
  }

  void update(double dt) {
    topHeadPipeRect = topHeadPipeRect.translate(_pipeSpeed*dt, 0);
    topBodyPipeRect = topBodyPipeRect.translate(_pipeSpeed*dt, 0);
    bottomHeadPipeRect = bottomHeadPipeRect.translate(_pipeSpeed*dt, 0);
    bottomBodyPipeRect = bottomBodyPipeRect.translate(_pipeSpeed*dt, 0);

    if (topBodyPipeRect.right < -20) {
      isVisible = false;
    }
  }
  void render(Canvas canvas) {
    topBodyPipeSprite.renderRect(canvas, topBodyPipeRect);
    topHeadPipeSprite.renderRect(canvas, topHeadPipeRect);
    bottomHeadPipeSprite.renderRect(canvas, bottomHeadPipeRect);
    bottomBodyPipeSprite.renderRect(canvas, bottomBodyPipeRect);
  }

  bool hasCollision(Rect rect) {
    return (topBodyPipeRect.overlaps(rect) || topHeadPipeRect.overlaps(rect) ||  bottomBodyPipeRect.overlaps(rect) || bottomHeadPipeRect.overlaps(rect));
  }
}