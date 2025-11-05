import 'package:flame/game.dart';

import '../animations/apple.dart';
import '../animations/banana.dart';
import '../animations/orange.dart';

class WordAnimation extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // final appleAnimation = await loadSpriteAnimation(
    //   'apple.png',
    //   SpriteAnimationData.sequenced(
    //       amount: 20,
    //       textureSize: Vector2.all(140),
    //       stepTime: 0.2,
    //       amountPerRow: 4,
    //       loop: false),
    // );

    // final spriteSize = Vector2.all(150.0);
    // final appleAnimationComponent = SpriteAnimationComponent(
    //   animation: appleAnimation,
    //   size: spriteSize,
    // );
    // appleAnimationComponent.x = 480;
    // appleAnimationComponent.y = 180;

    //add(appleAnimationComponent);
    add(Apple()..position = Vector2(480, 190));
    add(Banana()..position = Vector2(680, 140));
    add(Orange()..position = Vector2(980, 180));
  }
}
