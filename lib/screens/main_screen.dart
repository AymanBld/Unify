import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mental_health_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MentalHealthProvider>(
      builder: (context, provider, child) {
        String imagePath;
        switch (provider.plantStage) {
          case PlantStage.seed:
            imagePath = 'assets/images/seed.png';
            break;
          case PlantStage.sprout:
            imagePath = 'assets/images/sprout.png';
            break;
          case PlantStage.smallPlant:
            imagePath = 'assets/images/small_plant.png';
            break;
          case PlantStage.bigPlant:
            imagePath = 'assets/images/big_plant.png';
            break;
          case PlantStage.blooming:
            imagePath = 'assets/images/blooming.png';
            break;
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Mental Health Score: ${provider.user.currentScore}', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),
              Image.asset(imagePath, height: 300, fit: BoxFit.contain),
              const SizedBox(height: 20),
              Text(
                _getEncouragement(provider.plantStage),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        );
      },
    );
  }

  String _getEncouragement(PlantStage stage) {
    switch (stage) {
      case PlantStage.seed:
        return "Every journey begins with a seed. Take care of yourself.";
      case PlantStage.sprout:
        return "You are growing! Keep it up.";
      case PlantStage.smallPlant:
        return "You're getting stronger every day.";
      case PlantStage.bigPlant:
        return "Look at you flourish! Amazing progress.";
      case PlantStage.blooming:
        return "You are blooming! Radiant and strong.";
    }
  }
}
