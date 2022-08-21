import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';

class GameOver {
  late final Rect rect;
  late final Sprite sprite;
  final Rect screenSize;
  final int score;
  final int bestScore;
  final TextPaint scoreText = TextPaint(style: const TextStyle(fontSize: 45, fontFamily: "flappy_font", color: Colors.white));
  final TextPaint bestScoreText = TextPaint(style: const TextStyle(fontSize: 45, fontFamily: "flappy_font", color: Colors.white));
  GameOver({required this.screenSize, required Image image, required this.score, required this.bestScore}) {
    sprite = Sprite(image);
    rect = Rect.fromCenter(center: screenSize.center, width: screenSize.width / 2, height: screenSize.height / 2);
  }

  void update(double dt) {

  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
    scoreText.render(
      canvas,
      "Score: $score",
      Vector2(screenSize.width/2, screenSize.height/8),
      anchor: Anchor.center
    );
    bestScoreText.render(
      canvas,
      "Best: $bestScore",
      Vector2(screenSize.width/2, screenSize.height*6.5/8),
      anchor: Anchor.center
    );
  }
}