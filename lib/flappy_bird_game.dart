import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_flappy_bird/components/background.dart';
import 'package:flame_flappy_bird/components/bird.dart';
import 'package:flame_flappy_bird/components/game_over.dart';
import 'package:flame_flappy_bird/components/ground.dart';
import 'package:flame_flappy_bird/components/pipes.dart';
import 'package:flutter/material.dart' show Colors;

import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FlappyBird extends Game with TapDetector {
  late Background background;
  late List<Ground> groundList;
  late List<Pipes> pipes;
  late Bird bird;
  late GameOver gameOverScreen;
  late Timer timer;
  int score = 0;
  int bestScore = 0;
  late TextPaint textScore;

  bool isPlaying = false;
  @override
  Future<void> onLoad() async {
    //
    textScore = TextPaint(
      style: const  TextStyle(
        fontSize: 45.0,
        fontFamily: 'flappy_font',
        color: Colors.white
      ),
    );

    //background initialization
    background = Background(rect: size.toRect());

    //ground initialization
    createGround();

    //pipes initialization
    pipes = [];
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

    //game over screen initialization
    final prefs = await SharedPreferences.getInstance();
    bestScore = prefs.getInt("bestScore") ?? 0;
    final gameOverImage = await images.load("message.png");
    gameOverScreen = GameOver(screenSize: size.toRect(), image: gameOverImage, score: score, bestScore: bestScore);
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    if (isPlaying) {
      pipes.forEach((element) {element.render(canvas);});
      bird.render(canvas);
      textScore.render(canvas, score.toString(), Vector2(size.toRect().width/2, 100));
    } else {
      gameOverScreen.render(canvas);
    }
    groundList.forEach((element) {element.render(canvas);});
  }

  @override
  void update(double dt) {
    if (isPlaying) {
      timer.update(dt);
      //pipes movement
      pipes.forEach((element) {element.update(dt);});
      pipes.removeWhere((element) => element.isVisible == false);
      bird.update(dt);
      updateScore();
      gameOver();
    }

    //ground movement
    groundList.forEach((element) {element.update(dt);});
    groundList.removeWhere((element) => element.isVisible == false);
    if (groundList.length < 2) {
      createGround();
    }
  }

  void createGround() async {
    final Ground ground1 = Ground(leftPos: 0, screenSize: size.toRect());
    final Ground ground2 = Ground(leftPos: size.toRect().width, screenSize: size.toRect());
    groundList = [ground1, ground2];
  }

  void gameOver() {
    pipes.forEach((element) {
      if (element.hasCollision(bird.rect)) {
        reset();
      }
    });
    groundList.forEach((element) {
      if (element.hasCollision(bird.rect)) {
        reset();
      }
    });

    if (bird.rect.top <= 0) {
      reset();
    }
  }

  @override
  void onTap() {
    super.onTap();
    if (isPlaying) {
      bird.onTap();
    } else {
      score = 0;
      isPlaying = true;
    }
  }

  void reset() async {
    FlameAudio.play("hit.wav");
    isPlaying = false;
    await saveBestScore();
    timer.stop();
    bird.dispose();
    onLoad();
  }

  void updateScore() {
    pipes.forEach((element) {
      if ((element.canScore) && bird.rect.right >= element.topBodyPipeRect.left + element.topBodyPipeRect.width/2) {
        score++;
        FlameAudio.play("point.wav");
        element.disableScore();
        if (score > bestScore) bestScore = score;
      }
    });
  }

  Future<void> saveBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("bestScore", bestScore);
  }
}