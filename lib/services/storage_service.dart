import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';

class StorageService {
  static const String keyUser = 'user_data';
  static const String keyHistory = 'score_history';

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUser, jsonEncode(user.toMap()));
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userStr = prefs.getString(keyUser);
    if (userStr == null) return null;
    return UserModel.fromMap(jsonDecode(userStr));
  }

  Future<void> saveHistory(List<int> history) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert list of ints to list of strings because setStringList requires List<String>
    final List<String> strList = history.map((e) => e.toString()).toList();
    await prefs.setStringList(keyHistory, strList);
  }

  Future<List<int>?> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? strList = prefs.getStringList(keyHistory);
    if (strList == null) return null;
    return strList.map((e) => int.parse(e)).toList();
  }
}
