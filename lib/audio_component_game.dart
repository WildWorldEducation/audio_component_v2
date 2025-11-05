import 'package:flame/game.dart';
import 'word_animation.dart';
import 'Hero/hero_character.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import 'background.dart';
import 'Hero/direction.dart';

class AudioComponentGame extends FlameGame with ScrollDetector, ScaleDetector {
  final Vector2 viewportResolution;

  AudioComponentGame({
    required this.viewportResolution,
  });

  final WordAnimation _wordAnimation = WordAnimation();
  final Background _background = Background();
  final HeroCharacter _heroCharacter = HeroCharacter();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // camera.viewport = FixedResolutionViewport(viewportResolution);
    // camera.setRelativeOffset(Anchor.topLeft);
    // camera.speed = 1;

    await add(_background);
    add(_wordAnimation);
    add(_heroCharacter);
  }

  void onJoypadDirectionChanged(Direction direction) {
    _heroCharacter.direction = direction;
  }
}
