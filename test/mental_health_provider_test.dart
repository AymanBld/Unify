import 'package:flutter_test/flutter_test.dart';
import 'package:minda_thon/providers/mental_health_provider.dart';

void main() {
  group('MentalHealthProvider Tests', () {
    test('Initial score should be 50', () {
      final provider = MentalHealthProvider();
      expect(provider.user.currentScore, 50);
      expect(provider.plantStage, PlantStage.smallPlant); // 50 is smallPlant (40-60)
    });

    test('Score Update should change plant stage', () {
      final provider = MentalHealthProvider();

      // Decrease score to 10 (Seed)
      provider.updateScore(-40);
      expect(provider.user.currentScore, 10);
      expect(provider.plantStage, PlantStage.seed);

      // Increase score to 90 (Blooming)
      provider.updateScore(80);
      expect(provider.user.currentScore, 90);
      expect(provider.plantStage, PlantStage.blooming);
    });

    test('Score should be clamped between 0 and 100', () {
      final provider = MentalHealthProvider();

      provider.updateScore(100);
      expect(provider.user.currentScore, 100);

      provider.updateScore(-200);
      expect(provider.user.currentScore, 0);
    });
  });
}
