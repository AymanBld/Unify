import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';
import '../services/firestore_service.dart';

enum PlantStage { seed, sprout, smallPlant, bigPlant, blooming }

class MentalHealthProvider with ChangeNotifier {
  UserModel _user = UserModel(id: '1', name: 'User', email: 'user@example.com');
  List<int> _history = [50];
  final StorageService _storage = StorageService();
  final FirestoreService _firestoreService = FirestoreService();

  MentalHealthProvider() {
    loadUserData();
  }

  UserModel get user => _user;
  List<int> get history => _history;

  PlantStage get plantStage {
    if (_user.currentScore < 20) return PlantStage.seed;
    if (_user.currentScore < 40) return PlantStage.sprout;
    if (_user.currentScore < 60) return PlantStage.smallPlant;
    if (_user.currentScore < 80) return PlantStage.bigPlant;
    return PlantStage.blooming;
  }

  void updateScore(int delta) {
    int newScore = (_user.currentScore + delta).clamp(0, 100);
    _user = _user.copyWith(currentScore: newScore);
    _history.add(newScore);

    // Persist data
    _storage.saveUser(_user);
    _storage.saveHistory(_history);
    _firestoreService.syncUser(_user); // Cloud Sync

    notifyListeners();
  }

  Future<void> loadUserData() async {
    final storedUser = await _storage.getUser();
    final storedHistory = await _storage.getHistory();

    if (storedUser != null) {
      _user = storedUser;
    }
    if (storedHistory != null) {
      _history = storedHistory;
    }
    notifyListeners();
  }
}
